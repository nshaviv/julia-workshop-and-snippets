cd("Example-machine-learning")
using Pkg; Pkg.activate(".") # I had a clash between Flux and another package I used. The easiest was to activate a local environment  
#Pkg.add("Flux")
#Pkg.add("Plots")
#Pkg.add("ProgressMeter")

using Flux
using ProgressMeter 
using Statistics

####################################
# Make random mock data
num_groups = 4  # Number of groups
num_features = 10  # Number of features
base_vectors = [rand(Float32,num_features) for _ in 1:num_groups]  # num_groups random vectors, each of length num_features
σnoise = 0.2f0

num_samples_per_group = 50  # Number of samples in each group

function make_data()
    data = []
    labels = []
    for (group_idx, base_vec) in enumerate(base_vectors)
        for _ in 1:num_samples_per_group
            noisy_sample = base_vec + randn(Float32, num_features) * σnoise  # Add Gaussian noise
            push!(data, noisy_sample)
            push!(labels, group_idx)  # The label is the group index
        end
    end
    
    # Convert to appropriate format 
    # vector of vectors -> matrix
    inputs = hcat(data...)
    # vector of scalars -> one-hot matrix
    labels = Flux.onehotbatch(labels, 1:num_groups)
    (inputs, labels)        
end

inputs_train, labels_train = make_data()
inputs_valid, labels_valid = make_data()

############################################################
## Define the model

model = Chain(
    Dense(num_features, 10, relu),
    Dense(10, num_groups),
    softmax)

# Define the loss function (i.e. how far the model is from the truth)
# You can define any function you like. Here we use the mean squared error
# which is already defined in Flux
loss(x, y) = mse(model(x), y)

# Define the accuracy function (i.e. how often the model predicts the correct group)
# We don't need it for the solution, just for the evaluation of how good it is.
accuracy(x, y) = mean(Flux.onecold(model(x)) .== Flux.onecold(y))

# Define the optimizer (i.e. how to update the model parameters to reduce the loss)
optimizer = ADAM()

# Training
data =[(inputs_train, labels_train)]

for e ∈ 0:10000
    Flux.train!(loss, Flux.params(model), data, optimizer)
    if e % 1000 ==0 println(accuracy(inputs_valid, labels_valid), " ", loss(inputs_valid, labels_valid)) end
end 

