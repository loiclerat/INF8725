function [ modif ] = FunctionEx3( img, canal )
    
    modif = zeros(size(img,1),size(img,2),size(img,3),'uint8');
    
    modif(:,:,canal) = img(:,:,canal);
  
end

