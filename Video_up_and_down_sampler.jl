include("ActivateEnv.jl")


#entry point
#function main(inputpath::String, outputpath::String)
function main()

end





function start()
    RawVideo120fps = VideoIO.openvideo("IMG_0152.MOV")

    #downscale video
    RawVideo120fps = downscalevideo(RawVideo120fps)

    #rotate video
    #RawVideo120fps = rotatevideo(RawVideo120fps)


    #empty matrix to store frames
    imgstack_60fps = []
    imgstack_30fps = []
    imgstack_20fps = []
    imgstack_40fps = []

    #imgstack_test = []
    #for img in RawVideo120fps
    #    push!(imgstack_test, img)
    #end


    for (i,img) in enumerate(RawVideo120fps)
    
    
        #add frames to matrix   
        if (i%2 == 0)
            push!(imgstack_60fps, img)
        end

        if (i%4 == 0)
            push!(imgstack_30fps, img)
        end

        if (i%6 == 0)
            push!(imgstack_20fps, img)
        end

        if (i%3 == 0)
            push!(imgstack_40fps, img)
        end       

    end

    imgstack_30fps = upsample30to60fps(imgstack_30fps);
    imgstack_20fps = upsample20to60fps(imgstack_20fps);
    imgstack_40_30_60fps = upsample30to60fps(downsample40to30fps(imgstack_40fps));
    imgstack_40fps = upsample40to60fps(imgstack_40fps);

    #finds the smallest imagestack and reduces the other imagestacks to the same size
    minsize = min(length(imgstack_60fps), length(imgstack_30fps), length(imgstack_20fps), length(imgstack_40fps), length(imgstack_40_30_60fps))
    imgstack_60fps = imgstack_60fps[1:minsize];
    imgstack_30fps = imgstack_30fps[1:minsize];
    imgstack_20fps = imgstack_20fps[1:minsize];
    imgstack_40fps = imgstack_40fps[1:minsize];
    imgstack_40_30_60fps = imgstack_40_30_60fps[1:minsize];

    #reshape imgstack vectors to matrix
    imgstack_60fps = imgstack_60fps[:,:] 
    imgstack_30fps = imgstack_30fps[:,:]
    imgstack_20fps = imgstack_20fps[:,:]
    imgstack_40fps = imgstack_40fps[:,:]
    imgstack_40_30_60fps = imgstack_40_30_60fps[:,:]

    allimgstacks = []
    for (i,img) in enumerate(imgstack_60fps[:,1])
        push!(allimgstacks, [imgstack_20fps[i,1] imgstack_30fps[i,1] imgstack_40_30_60fps[i,1]; imgstack_60fps[i,1] imgstack_40fps[i,1] imgstack_30fps[i,1] ])
    end





    #save every imagestack as a video with 60fps
    #encoder_options = (crf=23, preset="medium")
    #VideoIO.save("vergleich.mp4", allimgstacks, framerate=60, encoder_options=encoder_options)

    #VideoIO.save("60fps.mp4", imgstack_60fps, framerate=60, encoder_options=encoder_options)
    #VideoIO.save("30fps.mp4", imgstack_30fps, framerate=60, encoder_options=encoder_options)
    #VideoIO.save("20fps.mp4", imgstack_20fps, framerate=60, encoder_options=encoder_options)
    #VideoIO.save("40fps.mp4", imgstack_40fps, framerate=60, encoder_options=encoder_options)
    #VideoIO.save("40_30_60fps.mp4", imgstack_40_30_60fps, framerate=60, encoder_options=encoder_options)

end




















