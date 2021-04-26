load('simStrategies');

strat16to1 = reshape(simStrategies(:,1,:),1,5*16);
strat8to1 = reshape(simStrategies(:,2,:),1,5*16);
strat4to1 = reshape(simStrategies(:,3,:),1,5*16);
strat2to1 = reshape(simStrategies(:,4,:),1,5*16);
strat1to1 = reshape(simStrategies(:,5,:),1,5*16);

STRATEGIES = 14;
NUMMAPS = 5;

figure;
subplot(2,1,1)
histogram(strat16to1,STRATEGIES,'BinEdges',[0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5 13.5 14.5])
title('Simulation of Goto Goal')
xticks(1:STRATEGIES)
xticklabels({'Sur', 'Top', 'Rte', 'Rev', 'SurRte', 'TopRte', 'SurRev', 'TopRev', 'RteSur', 'RteTop', 'RevSur', 'RevTop', 'SurTop', 'TopSur'})
xlabel('Strategy')
axis([0 15 0 55])
title('A. Simulation of Goto Goal')

% figure;
% subplot(2,2,2)
% histogram(strat8to1,STRATEGIES,'BinEdges',[0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5])
% title('Road to Route 8:1')
% xticks(1:STRATEGIES)
% xticklabels({'Sur', 'Top', 'Rte', 'Rev', 'SurRte', 'TopRte', 'SurRev', 'TopRev', 'RteSur', 'RteTop', 'RevSur', 'RevTop'})

% figure;
% subplot(2,2,3)
% histogram(strat4to1,STRATEGIES,'BinEdges',[0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5])
% title('Road to Route 4:1')
% xticks(1:STRATEGIES)
% xticklabels({'Sur', 'Top', 'Rte', 'Rev', 'SurRte', 'TopRte', 'SurRev', 'TopRev', 'RteSur', 'RteTop', 'RevSur', 'RevTop'})

% figure;
subplot(2,1,2)
histogram(strat2to1,STRATEGIES,'BinEdges',[0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5 13.5 14.5])
title('Simulation of Shortcut')
xticks(1:STRATEGIES)
xticklabels({'Sur', 'Top', 'Rte', 'Rev', 'SurRte', 'TopRte', 'SurRev', 'TopRev', 'RteSur', 'RteTop', 'RevSur', 'RevTop', 'SurTop', 'TopSur'})
xlabel('Strategy')
axis([0 15 0 55])
title('B. Simulation of Shortcut')


% figure;
% histogram(strat1to1,STRATEGIES,'BinEdges',[0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5])
% title('Road to Route 1:1')
% xticks(1:STRATEGIES)
% xticklabels({'Sur', 'Top', 'Rte', 'Rev', 'SurRte', 'TopRte', 'SurRev', 'TopRev', 'RteSur', 'RteTop', 'RevSur', 'RevTop'})


figure;

s = zeros(NUMMAPS,STRATEGIES);
count = zeros(1,NUMMAPS);
peaky = zeros(1,NUMMAPS);
stratVary16to1 = squeeze(simStrategies(:,1,:));
for i=1:size(stratVary16to1,1)
    for j=1:STRATEGIES
        s(i,j) = s(i,j)+sum(stratVary16to1(i,:) == j);
    end
    count(i) = sum(s(i,:) ~= 0);
    peaky(i) = max(s(i,:))/sum(s(i,:));
end
sv = ((1 - count./STRATEGIES) + peaky)/2;
subplot(1,2,1)
histogram(sv, 10,'BinEdges',[0.05 0.15 0.25 0.35 0.45 0.55 0.65 0.75 0.85 0.95 1.05])
title('Strategy Selection for Goto Goal Simulation')
xlabel('0=vary strategy; 1=always use same strategy')
sv16to1=sv;

s = zeros(NUMMAPS,STRATEGIES);
count = zeros(1,NUMMAPS);
peaky = zeros(1,NUMMAPS);
stratVary2to1 = squeeze(simStrategies(:,4,:));
for i=1:size(stratVary2to1,1)
    for j=1:STRATEGIES
        s(i,j) = s(i,j)+sum(stratVary2to1(i,:) == j);
    end
    count(i) = sum(s(i,:) ~= 0);
    peaky(i) = max(s(i,:))/sum(s(i,:));
end
sv = ((1 - count./STRATEGIES) + peaky)/2;
subplot(1,2,2)
histogram(sv, 10,'BinEdges',[0.05 0.15 0.25 0.35 0.45 0.55 0.65 0.75 0.85 0.95 1.05])
title('Strategy Selection for Shortcut Simulation')
xlabel('0=vary strategy; 1=always use same strategy')
sv2to1=sv;
