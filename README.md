# Video-Processing

******************************************************************************
		       Video Retrival by motion estimation 
******************************************************************************
Folder structure : 
|
|____ann-ts 				// Annotation and timestamp files
|	|__ activityAnnotations		// activities along with their start and stop timestamp
|	|__ timestamps			// offset needed for getting time in seconds
|
|____clips				// MAT files containing clips information
|
|____classification			// files needed for classifying the videos in the dataset
|	|__ cosine_distance.m		// cosine similarity between two video clips
|	|__ euclidean_distance.m	// Euclidean distance between wo videoclips
|	|__ Ndim_kmeans.m		// k-means clustering of the video frames
|	|__ splitVideo.m		// Split the video into small sequences based on k-means
|	|__ vect_per_Nframes.m		// average vector of N frames
|	|__ divide_in_grid.m		// Divide the frames into WxW grid
|
|____dataset				// MAT files containg feature vectors, which is nothing
|					// but motion vectors divided into WxW grid.
|
|____extraction				// Extracting Feature vectors from the videos
|	|__motion_vector		// Extracting motion vectors
|	|	|__Coarse2FineTwoFrames	// MEX file containing Ce Liu Optical flow C++ code
|	|	|__get_motionVect_celiu	// motion estimationa nd segmentation
|	|	|__thresholding.m		// motion segmentation using thresholding
|	|	|__feat_vect.m		// Extracting feature vector from the motion vector
|	|
|	|__reading			// Reading video frames from the avi files
|		|__get_inputClip.m	// getting input clip from the timestamp passed in the UI
|		|__read_avi_file.m	// read video frames from avi file
|
|____retrieval				// Retrieved information about the video clips
|	|__Heap.m			// Heap data structure
|	|__MinHeap.m			// Min heap data structure
|	|__Ranking.mat			// MAT files containg ranking information
|	|__output			// Output UI to display videos
|
|____report				// Final Report
|
|____main				// Main file
|
|____ui					// UI file to select video
|
|____playVideo.m			// function to play the video
|
|____README


Instruction : 

* Load the ui file
* Select the video file from the dataset folder
* select the activity you want to retrieve
* Retrieve Video
* When the output UI opens, select the folder where your dataset is present
* Click on any of the entry from the output list.
