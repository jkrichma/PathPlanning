for i= 1:5
    [mapWithLearnedRoute, mapWithoutLearnedRoute, landmarks, learnedRoute, trial] = makeMap (i, 32, 32, 1, 1, 0);
    save(['Map', num2str(i), '/map1_1.mat'],'mapWithLearnedRoute', 'mapWithoutLearnedRoute', 'landmarks', 'learnedRoute', 'trial')
    [mapWithLearnedRoute, mapWithoutLearnedRoute, landmarks, learnedRoute, trial] = makeMap (i, 32, 32, 2, 1, 0);
    save(['Map', num2str(i), '/map2_1.mat'],'mapWithLearnedRoute', 'mapWithoutLearnedRoute', 'landmarks', 'learnedRoute', 'trial')
    [mapWithLearnedRoute, mapWithoutLearnedRoute, landmarks, learnedRoute, trial] = makeMap (i, 32, 32, 4, 1, 0);
    save(['Map', num2str(i), '/map4_1.mat'],'mapWithLearnedRoute', 'mapWithoutLearnedRoute', 'landmarks', 'learnedRoute', 'trial')
    [mapWithLearnedRoute, mapWithoutLearnedRoute, landmarks, learnedRoute, trial] = makeMap (i, 32, 32, 8, 1, 0);
    save(['Map', num2str(i), '/map8_1.mat'],'mapWithLearnedRoute', 'mapWithoutLearnedRoute', 'landmarks', 'learnedRoute', 'trial')
    [mapWithLearnedRoute, mapWithoutLearnedRoute, landmarks, learnedRoute, trial] = makeMap (i, 32, 32, 16, 1, 0);
    save(['Map', num2str(i), '/map16_1.mat'],'mapWithLearnedRoute', 'mapWithoutLearnedRoute', 'landmarks', 'learnedRoute', 'trial')
end