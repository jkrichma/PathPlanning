%  * **********************************************************************
%  *
%  * Copyright (c) 2014 Regents of the University of California. All rights reserved.
%  *
%  * Redistribution and use in source and binary forms, with or without
%  * modification, are permitted provided that the following conditions
%  * are met:
%  *
%  * 1. Redistributions of source code must retain the above copyright
%  *    notice, this list of conditions and the following disclaimer.
%  *
%  * 2. Redistributions in binary form must reproduce the above copyright
%  *    notice, this list of conditions and the following disclaimer in the
%  *    documentation and/or other materials provided with the distribution.
%  *
%  * 3. The names of its contributors may not be used to endorse or promote
%  *    products derived from this software without specific prior written
%  *    permission.
%  *
%  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%  * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
%  * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
%  * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
%  * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
%  * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
%  * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
%  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
%  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%  *
%  * **********************************************************************

% makeMap - generates a Cartesian coordinate map with at least one obstacle.
%
% @param xDim - X dimension of the map.
% @param yDim - Y dimension of the map.
% @param makeRoad - if true, makes straight roads with low cost.
% @param twoObstacles - if true, makes a second obstacle with high cost.
% @param minorObstacles - if true, makes a random distribution of locations with moderate cost.
function [mapWithLearnedRoute, mapWithoutLearnedRoute, landmarks, learnedRoute, trial] = makeMap (mapSeed, xDim, yDim, roadVal, routeVal, dFlag)

NUMGOALS = 8;
NUMLM = 4;
outOfBoundVal = 120;
NUMTRIALS = 16;
trial = zeros(NUMTRIALS,4);

extraLM = [5 6 7 8 9 10 11 12 19 20 21 22 23 24 25 26 27 28];
NUMEXTRALM = 5;

rng(mapSeed);
mapWithoutLearnedRoute = outOfBoundVal*ones(xDim,yDim);

% make outer road
innerEdge = 2;
for i = innerEdge:xDim-innerEdge+1
    for j = innerEdge:yDim-innerEdge+1
        if i == innerEdge || i == xDim-innerEdge+1 || j == innerEdge || j == yDim-innerEdge+1
            mapWithoutLearnedRoute(i,j) = roadVal;
        end
    end
end

for i = 1:NUMGOALS
    if mod(i,2) == 0
        goal(i).x = randi([innerEdge+2 xDim-innerEdge-2],1);
        if rand > 0.5
            goal(i).y = innerEdge;
        else
            goal(i).y = yDim-innerEdge;
        end
    else
        if rand > 0.5
            goal(i).x = innerEdge;
        else
            goal(i).x = xDim-innerEdge;
        end
        goal(i).y = randi([innerEdge+2 yDim-innerEdge-2],1);
    end
    mapWithoutLearnedRoute(goal(i).x,goal(i).y) = roadVal;
end

for i = 1:NUMGOALS
    for j = 1:NUMGOALS
        if goal(i).x ~= goal(j).x && goal(i).y ~= goal(j).y && j > i
            if goal(i).x < goal(j).x && goal(i).y < goal(j).y
                mapWithoutLearnedRoute(goal(i).x:goal(j).x, goal(i).y) = roadVal;
                mapWithoutLearnedRoute(goal(j).x, goal(i).y:goal(j).y) = roadVal;
            elseif goal(i).x < goal(j).x && goal(i).y > goal(j).y
                mapWithoutLearnedRoute(goal(i).x:goal(j).x, goal(i).y) = roadVal;
                mapWithoutLearnedRoute(goal(j).x, goal(j).y:goal(i).y) = roadVal;
            elseif goal(i).x > goal(j).x && goal(i).y < goal(j).y
                mapWithoutLearnedRoute(goal(j).x:goal(i).x, goal(i).y) = roadVal;
                mapWithoutLearnedRoute(goal(j).x, goal(i).y:goal(j).y) = roadVal;
            else
                mapWithoutLearnedRoute(goal(j).x:goal(i).x, goal(i).y) = roadVal;
                mapWithoutLearnedRoute(goal(j).x, goal(j).y:goal(i).y) = roadVal;
            end
        end
    end
end

inx = 1;
landmarks(inx,:) = [2,2];
inx = inx + 1;
landmarks(inx,:) = [2 yDim/2];
inx = inx + 1;
landmarks(inx,:) = [2 yDim-1];
inx = inx + 1;
landmarks(inx,:) = [xDim/2 yDim-1];
inx = inx + 1;
landmarks(inx,:) = [xDim-1 yDim-1];
inx = inx + 1;
landmarks(inx,:) = [xDim-1 yDim/2];
inx = inx + 1;
landmarks(inx,:) = [xDim-1 2];
inx = inx + 1;
landmarks(inx,:) = [xDim/2 2];

% for i=3:floor(xDim/NUMLM):xDim
%     lm = find(mapWithoutLearnedRoute(i,:) == roadVal);
%     if size(lm,2) > 0
%         inx = inx + 1;
%         yinx = randi(size(lm,2));
%         landmarks(inx,:) = [i lm(yinx)];
%     end
% end

for i = 1:NUMEXTRALM
    inx1 = xDim;
    inx2 = yDim;
    while mapWithoutLearnedRoute(inx1,inx2) ~= roadVal
        inx1 = extraLM(randi(size(extraLM,2)));
        inx2 = extraLM(randi(size(extraLM,2)));
    end
    inx = inx+1;
    landmarks(inx,1) = inx1;
    landmarks(inx,2) = inx2;
end

landmarks = sortrows(landmarks, [1 2]);
lmInx = 0;
for i=2:xDim
    inx=find(landmarks(:,1) == i & landmarks(:,2) < yDim/2);
    for j=1:size(inx,1)
        lmInx = lmInx + 1;
        lr(lmInx,:) = landmarks(inx(j),:);
    end
    
end
for i=xDim:-1:2
    inx=find(landmarks(:,1) == i & landmarks(:,2) >= yDim/2);
    for j=1:size(inx,1)
        lmInx = lmInx + 1;
        lr(lmInx,:) = landmarks(inx(j),:);
    end
    
end

tmp = lr(end,:);
lr(end,:) = lr(end-1,:);
lr(end-1,:) = tmp;

inx=0;
mapWithLearnedRoute = mapWithoutLearnedRoute;
for i=1:size(lr,1)-1
    p = spikeWave (mapWithLearnedRoute, lr(i,1), lr(i,2), lr(i+1,1), lr(i+1,2), 0);
    for j=size(p,2):-1:2
        inx=inx+1;
        learnedRoute(inx,1)=p(j).x;
        learnedRoute(inx,2)=p(j).y;
    end
end
p = spikeWave (mapWithLearnedRoute, lr(end,1), lr(end,2), lr(1,1), lr(1,2), 0);
for j=size(p,2):-1:2
    inx=inx+1;
    learnedRoute(inx,1)=p(j).x;
    learnedRoute(inx,2)=p(j).y;
end

for i=1:size(learnedRoute,1)
    mapWithLearnedRoute(learnedRoute(i,1),learnedRoute(i,2)) = routeVal;
end

for i=1:NUMTRIALS
    start = randi(size(landmarks,1));
    stop = randi(size(landmarks,1));
    while start == stop || landmarks(start,1) == landmarks(stop,1) || landmarks(start,2) == landmarks(stop,2)
        start = randi(size(landmarks,1));
        stop = randi(size(landmarks,1));
    end
    trial(i,:) = [landmarks(start,1) landmarks(start,2) landmarks(stop,1) landmarks(stop,2)];
end

if dFlag
%     subplot(1,2,1)
%     imagesc(mapWithLearnedRoute); colorbar;
%     axis square;
%     subplot(1,2,2)
%     imagesc(mapWithoutLearnedRoute);colorbar;
%     axis square;
    imagesc(mapWithLearnedRoute); axis off;
    axis square;
end

end


