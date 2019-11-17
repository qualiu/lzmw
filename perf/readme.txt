Compared lzmw with findstr (Windows tool) and grep (Linux tool) on Windows and Cygwin.
Performance comparison results as shown in these images in this folder:
https://raw.githubusercontent.com/qualiu/lzmw/master/perf/on-Cygwin-comparison.PNG
https://raw.githubusercontent.com/qualiu/lzmw/master/perf/on-Windows-comparison.PNG

lzmw is faster than findstr when using complicated regex pattern and ignore case matching;
and a bit faster than grep when finding plain text;
other conditions slower than them (lack of other regex performance testing)

But lzmw support all regex syntax and has much much more functions than them.

lzmw performance on different platforms differs due to several important factors :
(1) Implementations of STL and BOOST on different platforms are different.
(2) Outputting used std::cout which is much slower than fprintf/printf.
(3) BOOST regex performance.
