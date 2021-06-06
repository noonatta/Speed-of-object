function s(vidObj)

c=2;
val=1;
count=1;
while hasFrame(vidObj)
    frame2 = readFrame(vidObj);
    frame2=rgb2gray(frame2);
    thersold = graythresh(frame2);
    frame2=~im2bw(frame2,0.3);
  
    for i=1:size(frame2,1)
        for j=1:size(frame2,2)
            if frame2(i,j)==1
                
               
                if c==2
                    firstframe=frame2;
                    initialtime=vidObj.CurrentTime;
                    cordX1=i;
                    cordY1=j;
                    c=c+1;
                end
                
                val=1;
                break;
            end
        end
        if val==1
            break;
        end
    end
    
    if val==1
        while val~=0
            frame2=readFrame(vidObj);
            frame2=~im2bw(frame2,0.3);
            for i=1:size(frame2,1)
                for j=1:size(frame2,2)
                    if frame2(i,j)==0
                        f=0;
                        x2=i;
                        y2=j;
                    else
                        f=1;
                        break;
                    end
                end
            end
            if f==0
                lastframe=frame2;
                cordX2=x2;
                cordY2=y2;
                finaltime=vidObj.CurrentTime;
               
                val=0;
            end
        end
    end
    count=count+1;
end

%  distace was assumed 1 pix = 10 cm
distance=sqrt((cordX1-cordX2)^2 +(cordY1-cordY2)^2)/10;
time=finaltime-initialtime; % time when car appear - time when car is hoing dissapeared
speed_car=distance/time;

f=figure();
subplot(2, 2, 1);
imshow(firstframe, []);
axis on;
axis image;
title("Object's first location in video", 'FontSize', 20);

subplot(2, 2, 3);
imshow(lastframe, []);
axis on;
axis image;
title("Object's final location in video", 'FontSize', 20);



subplot(2,2,2)
axis off;
caption2 = sprintf('Assumed 1 pixel = 10 cm\nDistance = %f cm, \n Time = %f s, \n Speed = %f cm/s' ,distance, time, speed_car);
title(caption2, 'FontSize', 20);
end

