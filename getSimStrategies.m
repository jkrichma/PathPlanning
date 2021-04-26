function strategy=getSimStrategies

FD1 = 5;
FD2 = 5;
FD3 = 16;
FD4 = 14;

strategy = zeros(FD1,FD2,FD3);


for i = 1:FD1
    fd=runSimTrials(i,0);
    save(['fdSimMap', num2str(i), '.mat'], 'fd');
    for j=1:FD2
        f = reshape(fd(j,:,:),FD3,FD4);
        [m,strategy(i,j,:)]=min(f,[],2);
    end
end


