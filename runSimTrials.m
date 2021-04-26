function fdTable = runSimTrials(mapNum, dFlag)

NUMTRIALS = 16;
STRATEGIES=14;
NUMRTEVAL = 5;
fdTable = zeros(NUMRTEVAL,NUMTRIALS,STRATEGIES);
roadVal = [16 8 4 2 1];

for r = 1:size(roadVal,2)
    load(['Map', num2str(mapNum), '/map', num2str(roadVal(r)), '_1.mat'], 'landmarks', 'learnedRoute', 'mapWithLearnedRoute', 'mapWithoutLearnedRoute', 'trial');
    disp(' ')
    disp(['Map', num2str(mapNum), ' RoadVal=', num2str(roadVal(r)), ' RteVal=1'])
    for i=1:NUMTRIALS
        disp(['--Trial ', num2str(i)])
        t = trial(i,:);
        [fdTable(r,i,1), fdTable(r,i,2), fdTable(r,i,3), fdTable(r,i,4), fdTable(r,i,5), fdTable(r,i,6), fdTable(r,i,7), fdTable(r,i,8), fdTable(r,i,9), fdTable(r,i,10), fdTable(r,i,11), fdTable(r,i,12), fdTable(r,i,13), fdTable(r,i,14)] = runTrialMixStratSim (t, mapWithLearnedRoute, mapWithoutLearnedRoute, learnedRoute, landmarks, 0);
    end
    if dFlag
        figure;
        fdTbl = reshape(fdTable(r,:,:),NUMTRIALS,STRATEGIES);
        imagesc(fdTbl);
        set(gca,'XTick',1:14)
        set(gca,'XTickLabel',{'Sur', 'Top', 'Rte', 'Rev', 'SurRte', 'TopRte', 'SurRev', 'TopRev', 'RteSur', 'RteTop', 'RevSur', 'RevTop', 'SurTop', 'TopSur'})
        set(gca,'YTick',1:NUMTRIALS)
        title(['Map', num2str(mapNum), ' - Frechet Distance  RoadVal=', num2str(roadVal), ' RteVal=', num2str(r)])
        colorbar;
    end
end

end

