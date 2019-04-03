# Video-Processing

******************************************************************************
		       Video Retrival by motion estimation 
******************************************************************************
In this work a content based video retrieval system is implemented using the low level features of the video such as motion vectors. A dataset containing set of videos is passed to the training module which first generates the motion vectors using appropriate window size. These generated motion vectors are clustered with a predetermined number of clusters. This trained dataset can now be used for retrieving relevant videos for a given input video. An average motion vector is calculated for each clustered segments and the input video which are then compared using Euclidean distance and Cosine distance. The segment with the least distance in comparison to the input implies they are most similar. Finally, all the calculated comparisons are used to create the ranking system which uses a Heap to store the retrieved videos.

Instruction : 

* Load the ui file
* Select the video file from the dataset folder
* select the activity you want to retrieve
* Retrieve Video
* When the output UI opens, select the folder where your dataset is present
* Click on any of the entry from the output list.
