# Motor_Neuron_pool_Design_and_Implementation
Design of a model of motor neuron pools performing movements to test online decoding algorithms based on EMG recordings (Course Project).
 
The aim of this project was to contribute to the development of the neural prosthesis control. To facilitate the training and testing of the decoding algorithms for prosthesis movement identification and control, we propose a novel model to simulate the peripheral neural motor activity observed using electromyogram (EMG) and the initial steps towards simulating intrafascicular technologies.

The model is tested with a classification task, which considers isokinetic and isotonic arm tasks, the excitatory input, the biological motoneuron model, the anatomical and physiological muscle properties, and the recording device. The code contains the design and implementation of:

•	The excitatory input

•	Motoneuron model: Izhikevic tonic neuron, Recruitment strategy

•	Motor units properties: Location and size of each motor unit territory, Location of the fibers within a motor neuron territory, Motor Unit Action Potential

•	Isometric force model for motor units

•	Recording model: EMG recording model, Intrafascicular recordings

•	Decoding algorithm: Spike train decoding, EMG signal decoding
