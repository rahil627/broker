package broker.image;

/**
	Pixels data.
**/
#if heaps
typedef Pixels = broker.image.heaps.Pixels;
#else
typedef Pixels = Dynamic;
#end
