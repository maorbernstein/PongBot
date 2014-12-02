%% openCV()
% The function "openCV" detects the cups and the ball 
% The file name of image file should be 'img1.jpg' 
% no input value.
% This function returns a structure array which contains radius, positions, and processed images of the cups and the ball 

function circles=openCV()
image = imread('img1.jpg');
figure(1) % show the detected cups on figure 1
[img_cups, cen_cups, rad_cups]=cupdetect(image);
figure(2) % show the detected ball on figure 2
[img_ball, cen_ball, rad_ball]=balldetect(image);
%figure(3)
[img_ref, cen_ref, rad_ref]=refdetect(image);
circles = struct('img_cups', img_cups, 'cen_cups', cen_cups, 'rad_cups', rad_cups, 'img_ball', img_ball, 'cen_ball', cen_ball, 'rad_ball', rad_ball, 'img_ref', img_ref, 'cen_ref', cen_ref, 'rad_ref', rad_ref);
end

%%
function [newimage, centers, radii]=balldetect(image)
    x=size(image,2);
    y=size(image,1);
    newimage=zeros(y,x);
    for j = 1:x
        for i = 1:y
            if (image(i,j,1)>150 && image(i,j,2)>80 && image(i,j,3)<120) % color of ball is orange, we try to detect orange color
                newimage(i,j,1)=1;
            else
                newimage(i,j,1)=0;
            end
        end
    end
    [centers, radii, metric] = imfindcircles(newimage,[20 30],'Sensitivity',0.96,'EdgeThreshold', 0.1); % find the ball
    imshow(newimage);
    viscircles(centers, radii,'EdgeColor','r'); % show detected ball
end
%%
function [newimage, centers, radii]=refdetect(image)
    newimage= rgb2gray(image) < 50;
    %imshow(newimage);
    [centers, radii, metric] = imfindcircles(newimage,[45 60],'Sensitivity',0.94,'EdgeThreshold', 0.1);
    viscircles(centers, radii,'EdgeColor','r'); 
end
%%
function [newimage, centers, radii]=cupdetect(image)
    newimage= rgb2gray(image) > 180; % image process; color of cups is white,so we try to detect white color
    imshow(newimage);
    [centers, radii, metric] = imfindcircles(newimage,[45 60],'Sensitivity',0.94,'EdgeThreshold', 0.1); % find the cups
    viscircles(centers, radii,'EdgeColor','r'); % show detected cups
    hold on;
    
    for i=1:size(centers,1)
        text(centers(i,1),centers(i,2),num2str(i),'Color','r','FontSize',20) % cup-numbering
    end
end