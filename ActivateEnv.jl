import Pkg 
Pkg.activate("videosampler")
Pkg.instantiate()
using VideoIO, Images
include("videosampler.jl")
