
f=figure('figure_position',[335,54],'figure_size',[881,562],'auto_resize','on','background',[33],'figure_name','Figure n°%d','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
handles.dummy = 0;
handles.Load_Image=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0509259,0.1475096,0.1481481,0.0555556],'Relief','default','SliderStep',[0.01,0.1],'String','Load Image','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','Load_Image','Callback','Load_Image_callback(handles)')
handles.apply=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.25,0.1494253,0.1493056,0.0498084],'Relief','default','SliderStep',[0.01,0.1],'String','Webcam','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','apply','Callback','apply_callback(handles)')
handles.highpass=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[1],'Max',[4],'Min',[2],'Position',[0.4408102,0.5996169,0.1283796,0.2528736],'Relief','default','SliderStep',[0.01,0.1],'String','High-Pass Filter','Style','listbox','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','highpass','Callback','highpass_callback(handles)')
handles.lowpass=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[1],'Max',[4],'Min',[2],'Position',[0.4408102,0.2988506,0.1283796,0.2528736],'Relief','default','SliderStep',[0.01,0.1],'String','Low-Pass Filter','Style','listbox','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','lowpass','Callback','lowpass_callback(handles)')
handles.img1= newaxes();handles.img1.margins = [ 0 0 0 0];handles.img1.axes_bounds = [0.0486111,0.0957854,0.3506944,0.6551724];
handles.img2= newaxes();handles.img2.margins = [ 0 0 0 0];handles.img2.axes_bounds = [0.6006944,0.0977011,0.349537,0.6532567];


f.visible = "on";


set(handles.highpass, 'string', 'Sobel(3x3)|Sobel(5*5)|Prewitt|Laplace(3x3)|Laplace(5x5)|Log|Canny|FFT Gradient |FFT Gradient 2|Threshold|Video Breaker');
//set(handles.highpass,'value',[1 3]); // PAS BESOIN A PRIORI


set(handles.lowpass, 'string', 'Gauss(3*3)|Gauss(5*5)|Blur(3x3)|Blur(5x5)|Blur(7x7)');






function Load_Image_callback(handles)



fn = uigetfile('*');
S = imread(fn);
sca(handles.img1);
imshow(S);

handles.S = S;
handles = resume(handles);

 
endfunction



function apply_callback(handles)


    



n = camopen(0);
S = camread(n); 
imshow(S);

sca(handles.img2);

for cnt = 1:1000
    S = camread(n);
     S2 = rgb2gray(S);
        sca(handles.img2);
        val = get(handles.highpass,'value');
        select val
        case 1 then
            
        F1 = fspecial('sobel');
        S3 = imfilter(S2,F1);
        imshow(S3);
            
                
        
    case 2 then
        F1 = [1,2,0,-2,-1;4,8,0,-8,-4;6,12,0,-12,-6;4,8,0,-8,-4;1,2,0,-2,-1];
        S3 = imfilter(S2,F1);
        imshow(S3);        


    case 3 then 
        
        F1 = fspecial('prewitt');

        S3 = imfilter(S2,F1);
        imshow(S3);

        
    case 4 then
        F1 = fspecial('laplacian',0.2);
        S3 = imfilter(S2,F1);
        imshow(S3);
        


    case 5 then
        F1 = [1,1,1,1,1;1,1,1,1,1;1,1,-24,1,1;1,1,1,1,1;1,1,1,1,1];
        S3 = imfilter(S2,F1);
        imshow(S3);
        
    case 6 then 
        F1 = fspecial('log',[5 5],0.5);
        S3 = imfilter(S2,F1);
        imshow(S3);
        
    case 7 then 
        S3 = edge(S2, 'canny', [0.06  0.2]);
        imshow(S3);
        
        
    case 8 then 
        S3 = edge(S2,'fftderiv', 0.4);
        imshow(S3);
        
        
        
    case 9 then 
        S3 = edge(S2,'fftderiv',signma = 3,thresh=-1);
        imshow(S3);
        
            
    case 10 then 
        S3 = edge(S2,thresh=-1);
        imshow(S3);
        
    case 11 then
        camcloseall();
        delete(handles.img2);
        handles.img2= newaxes();
        handles.img2.margins = [ 0 0 0 0];
        handles.img2.axes_bounds = [0.6006944,0.0977011,0.349537,0.6532567];
        handles = resume(handles);
        

        
        
        
        
        

        
       /*
        
        
        close(handles.img2);
        handles.img2= newaxes();
        handles.img2.margins = [ 0 0 0 0];
        handles.img2.axes_bounds = [0.6006944,0.0977011,0.349537,0.6532567];
        
        
        */
        


        break

        end
end




endfunction




function highpass_callback(handles) 
    val = get(handles.highpass,'value')
    select val
    case 1 then
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        F1 = fspecial('sobel');
        S3 = imfilter(S2,F1);
        imshow(S3);
        
    case 2 then
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        F1 = [1,2,0,-2,-1;4,8,0,-8,-4;6,12,0,-12,-6;4,8,0,-8,-4;1,2,0,-2,-1];
        S3 = imfilter(S2,F1);
        imshow(S3);        


    case 3 then 
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        F1 = fspecial('prewitt');
        S3 = imfilter(S2,F1);
        imshow(S3);

        
    case 4 then
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        F1 = fspecial('laplacian',0.2);
        S3 = imfilter(S2,F1);
        imshow(S3);
        


    case 5 then
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        F1 = [1,1,1,1,1;1,1,1,1,1;1,1,-24,1,1;1,1,1,1,1;1,1,1,1,1];
        S3 = imfilter(S2,F1);
        imshow(S3);
        
    case 6 then 
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        F1 = fspecial('log',[5 5],0.5);
        S3 = imfilter(S2,F1);
        imshow(S3);
        
    case 7 then 
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        S3 = edge(S2, 'canny', [0.06  0.2]);
        imshow(S3);
        
        
    case 8 then 
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        S3 = edge(S2,'fftderiv', 0.4);
        imshow(S3);
        
        
        
    case 9 then 
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        S3 = edge(S2,'fftderiv',signma = 3,thresh=-1);
        imshow(S3);
        
            
    case 10 then 
        S2 = rgb2gray(handles.S);
        sca(handles.img2);
        S3 = edge(S2,thresh=-1);
        imshow(S3);

             
    end







/*


List_item = get(handles.highpass, 'string');
disp(typeof(List_item));
disp("Premiere List_item")
disp(List_item);


disp("2e List_item")
if(List_item == 'item 1|item 2|item 3|item 4|item 5| item 6 | item 7')
    disp(List_item);
end;
    
    

*/
endfunction


function lowpass_callback(handles)



val = get(handles.lowpass,'value')
    select val
    case 1 then
        S2 = handles.S;
        sca(handles.img2);
        F1 = fspecial('gaussian',[3,3],0.5);

        S3 = imfilter(S2,F1);
        imshow(S3);
        
    case 2 then
        S2 = handles.S;
        sca(handles.img2);
        F1 = 1/256 * [1,4,6,4,1;4,16,24,16,4;6,24,36,24,6;4,16,24,16,4;1,4,6,4,1];

        S3 = imfilter(S2,F1);
        imshow(S3);

        
           
    case 3 then 
        S2 = handles.S;
        sca(handles.img2);
        F1 = [1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
        disp(F1);
        S3 = imfilter(S2,F1);
        imshow(S3);
        
        
           
    case 4 then 
        S2 = handles.S;
        sca(handles.img2);
        F1 = [1/15,1/15,1/15,1/15,1/15;1/15,1/15,1/15,1/15,1/15;1/15,1/15,1/15,1/15,1/15];

        S3 = imfilter(S2,F1);
        imshow(S3);

    case 5 then 
        S2 = handles.S;
        sca(handles.img2);
        F1 = [1/21,1/21,1/21,1/21,1/21,1/21,1/21;1/21,1/21,1/21,1/21,1/21,1/21,1/21;1/21,1/21,1/21,1/21,1/21,1/21,1/21];
        S3 = imfilter(S2,F1);
        imshow(S3);
        
     end

endfunction





