using VideoIO, Images

#funktion for video upsampling from 30fps to 60fps
function upsample30to60fps(imgstack_30fps)
    imgstack_60fps = []
    for (i,img) in enumerate(imgstack_30fps)
        push!(imgstack_60fps, img)
        push!(imgstack_60fps, img)
    end
    return imgstack_60fps
end

#funktion for video upsampling from 20fps to 60fps  
function upsample20to60fps(imgstack_20fps)
    imgstack_60fps = []
    for (i,img) in enumerate(imgstack_20fps)
        push!(imgstack_60fps, img)
        push!(imgstack_60fps, img)
        push!(imgstack_60fps, img)
    end
    return imgstack_60fps
end

#function for video downsampling from 40fps to 30fps
function downsample40to30fps(imgstack_40fps)
    imgstack_30fps = []
    for (i,img) in enumerate(imgstack_40fps)
        if (i%4 != 0)
            push!(imgstack_30fps, img)
        end
    end
    return imgstack_30fps
end

#funktion for video upsampling from 40fps to 60fps
function upsample40to60fps(imgstack_40fps)
    imgstack_60fps = []
    for (i,img) in enumerate(imgstack_40fps)
        if (i%2 == 0)
            push!(imgstack_60fps, img)
            push!(imgstack_60fps, img)
        else    
            push!(imgstack_60fps, img)
        
        end    
    end
    return imgstack_60fps
end



#function for viedeo downscale resolution of every image in the video
function downscalevideo(RawVideo120fps)
    downscale120fps = []
    for (i,img) in enumerate(RawVideo120fps)
        #print(size(img))
        push!(downscale120fps, imresize(img, (576,1024)))
    end  
    return downscale120fps
end

#function to rotate every image in the video to the right by 90°
function rotatevideo(RawVideo120fps)
    rotate120fps = []
    for (i,img) in enumerate(RawVideo120fps)
        push!(rotate120fps, transpose(img))
        #rotate120fps[i]
    end  
    return rotate120fps
end
