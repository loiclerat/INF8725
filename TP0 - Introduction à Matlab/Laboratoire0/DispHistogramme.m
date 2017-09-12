function [ ] = DispHistogramme( img, canal )
    
    histo = imhist(img(:,:,canal));
    histo = histo / sum(histo);
    
    if canal == 1
        bar(histo,'r' );
    elseif canal == 2
        bar(histo,'g');
    else
        bar(histo,'b');
    end
    
    xlim([0,255]);
    ylim([0,1]);
    

end

