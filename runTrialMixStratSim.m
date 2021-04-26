function [fdSurv, fdTopo, fdRt, fdRtRev, fdSurvRte, fdTopoRte, fdSurvRteRev, fdTopoRteRev, fdRteSurv, fdRteTopo, fdRteRevSurv, fdRteRevTopo, fdSurvTopo, fdTopoSurv] = runTrialMixStratSim (trial, mapRte, mapNoRte, rte, lm, dFlag)

rows = 2;
cols = 2;

if dFlag
    figure;
    subplot(rows, cols, 1)
end

p = spikeWave (mapRte, trial(1), trial(2), trial(3), trial(4), dFlag);
inx=0;
for i=size(p,2):-1:1
    inx=inx+1;
    subPath(inx,1)=p(i).x;
    subPath(inx,2)=p(i).y;
end

p = spikeWave (mapNoRte, trial(1), trial(2), trial(3), trial(4), dFlag);
inx=0;
for i=size(p,2):-1:1
    inx=inx+1;
    pSurv(inx,1)=p(i).x;
    pSurv(inx,2)=p(i).y;
end
[fdSurv, cSq] = DiscreteFrechetDist(pSurv,subPath);

if dFlag
    disp(['   Survey distance = ', num2str(fdSurv)])
end

if dFlag
    subplot(rows,cols,2)
end
p = topoWave (mapNoRte, lm, trial(1), trial(2), trial(3), trial(4), dFlag);
inx=0;
for i=size(p,2):-1:1
    inx=inx+1;
    pTopo(inx,1)=p(i).x;
    pTopo(inx,2)=p(i).y;
end
[fdTopo, cSq] = DiscreteFrechetDist(pTopo,subPath);

if dFlag
    disp(['   Topological distance = ', num2str(fdTopo)])
end

if dFlag
    subplot(rows,cols,3)
end
p = routeStrategySim (mapRte, trial(1), trial(2), trial(3), trial(4), rte, 0, dFlag);
inx=0;
for i=1:size(p,2)
    inx=inx+1;
    pRte(inx,1)=p(i).x;
    pRte(inx,2)=p(i).y;
end
[fdRt, cSq] = DiscreteFrechetDist(pRte,subPath);

if dFlag
    disp(['   Route distance = ', num2str(fdRt)])
end

if dFlag
    subplot(rows,cols,4)
end
p = routeStrategySim (mapRte, trial(1), trial(2), trial(3), trial(4), rte, 1, dFlag);
inx=0;
for i=1:size(p,2)
    inx=inx+1;
    pRteRev(inx,1)=p(i).x;
    pRteRev(inx,2)=p(i).y;
end
[fdRtRev, cSq] = DiscreteFrechetDist(pRteRev,subPath);

if dFlag
    disp(['   Route Reverse distance = ', num2str(fdRtRev)])
end

% spike wave then route
if dFlag
    figure;
    subplot(rows,cols,1)
end
pSurvRte = waveRouteSim (mapRte, rte, pSurv, 0, 0, dFlag);
[fdSurvRte, cSq] = DiscreteFrechetDist(pSurvRte,subPath);
if dFlag
    disp(['   Survey then Route distance = ', num2str(fdSurvRte)])
end

% topo wave then route
if dFlag
    subplot(rows,cols,2)
end
pSurvRte = waveRouteSim (mapRte, rte, pTopo, 1, 0, dFlag);
[fdTopoRte, cSq] = DiscreteFrechetDist(pSurvRte,subPath);
if dFlag
    disp(['   Topo then Route distance = ', num2str(fdTopoRte)])
end

% spike wave then reverse route
if dFlag
    subplot(rows,cols,3)
end
pSurvRte = waveRouteSim (mapRte, rte, pSurv, 0, 1, dFlag);
[fdSurvRteRev, cSq] = DiscreteFrechetDist(pSurvRte,subPath);
if dFlag
    disp(['   Survey then Reverse Route distance = ', num2str(fdSurvRteRev)])
end

% topo wave then reverse route
if dFlag
    subplot(rows,cols,4)
end
pSurvRte = waveRouteSim (mapRte, rte, pTopo, 1, 1, dFlag);
[fdTopoRteRev, cSq] = DiscreteFrechetDist(pSurvRte,subPath);
if dFlag
    disp(['   Topo then Route distance = ', num2str(fdTopoRteRev)])
end

% route then spike wave
if dFlag
    figure;
    subplot(rows,cols,1)
end
pRteSurv = routeWave (mapNoRte, lm, pRte, 0, 0, dFlag);
[fdRteSurv, cSq] = DiscreteFrechetDist(pRteSurv,subPath);
if dFlag
    disp(['   Route then Survey distance = ', num2str(fdRteSurv)])
end

% route then topological wave
if dFlag
    subplot(rows,cols,2)
end
pRteTopo = routeWave (mapNoRte, lm, pRte, 1, 0, dFlag);
[fdRteTopo, cSq] = DiscreteFrechetDist(pRteTopo,subPath);
if dFlag
    disp(['   Route then Topo distance = ', num2str(fdRteTopo)])
end

% reverse route then spike wave
if dFlag
    subplot(rows,cols,3)
end
pRteRevSurv = routeWave (mapNoRte, lm, pRteRev, 0, 1, dFlag);
[fdRteRevSurv, cSq] = DiscreteFrechetDist(pRteRevSurv,subPath);
if dFlag
    disp(['   Reverse Route then Survey distance = ', num2str(fdRteRevSurv)])
end

% reverse route then topological wave
if dFlag
    subplot(rows,cols,4)
end
pRteRevTopo = routeWave (mapNoRte, lm, pRteRev, 1, 1, dFlag);
[fdRteRevTopo, cSq] = DiscreteFrechetDist(pRteRevTopo,subPath);
if dFlag
    disp(['   Reverse Route then Topo distance = ', num2str(fdRteRevTopo)])
end

% survey then topological wave
if dFlag
    subplot(rows,cols,4)
end
pSurvTopo = routeWave (mapNoRte, lm, pSurv, 1, 0, dFlag);
[fdSurvTopo, cSq] = DiscreteFrechetDist(pSurvTopo,subPath);
if dFlag
    disp(['   Survey then Topo distance = ', num2str(fdSurvTopo)])
end

% topological then spike wave
if dFlag
    subplot(rows,cols,3)
end
pTopoSurv = routeWave (mapNoRte, lm, pTopo, 0, 0, dFlag);
[fdTopoSurv, cSq] = DiscreteFrechetDist(pTopoSurv,subPath);
if dFlag
    disp(['   Topological then Survey distance = ', num2str(fdTopoSurv)])
end

if dFlag
    figure;
    subplot(2,1,1)
    subMap = mapNoRte;
    subMap(subPath(1,1),subPath(1,2)) = 50;
    for i=2:size(subPath,1)-1
        subMap(subPath(i,1),subPath(i,2)) = 20;
    end
    subMap(subPath(end,1),subPath(end,2)) = 75;
    imagesc(subMap);
    axis square;
    axis off;
    title('Baseline Subject')
    subplot(2,1,2)
    bar([fdSurv fdTopo fdRt, fdRtRev, fdSurvRte, fdTopoRte, fdSurvRteRev, fdTopoRteRev, fdRteSurv, fdRteTopo, fdRteRevSurv, fdRteRevTopo])
    set(gca,'XTickLabel',{'Sur', 'Top', 'Rte', 'Rev', 'SurvRte', 'TopoRte', 'SurvRev', 'TopoRev', 'RteSur', 'RteTopo', 'RevSur', 'RevTopo', 'SurvTopo', 'TopoSurv'})
    title('Baseline Subject - Frechet Distance')
end

end
