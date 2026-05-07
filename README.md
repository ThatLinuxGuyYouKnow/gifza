# GIFZA
(![Strict asian Obama](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2pub3V6bjRraXE5a2wyc2J6MXF1OTk2NndjeDliemt2bjhia2l5YyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/MUR7zOhXhFoSvq0Rf6/giphy.gif))

Have you ever had an Image you've struggled to find, or the perfect sticker / GIF to send in the group chat at just the right time? Well I have and thats why I build Gifza.

Gifza(Gif-zah) is a semantic search engine for your visual assets. Simply upload an image / sticker / GIF, add an annotation / tag, and look it up anytime with the power of vector search. 

## Technical Details

Gifza uses Apples MoileCLIP S1, split into image and text encoders to generate embeddings for images and annotation text

Image emebeddings and tag / annotation embeddings are stored in Key, Value pairs in object box.

On query / search, the query embeddings is used to find similar assets with ANN(Approximate Nearest Neighbour), performed natively by ObjectBox



