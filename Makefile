# makefile for libgsm

TARGET = libflare
VERSION = 3
LIBPATH = -L/usr/local/netcdf-cxx-legacy/lib -L/usr/local/cuda/lib64	# Netcdf-c++ libaray path
INCPATH = -I/usr/local/netcdf-cxx-legacy/include -I/usr/local/netcdf-c/include -I/usr/local/cuda/include  # need paths to netcdf-c as well as c++ includes
LDFLAGS =  
CPPFLAGS = -O3 -Wl,--no-as-needed -std=c++11 -fPIC 
CUDAFLAGS = -std=c++11 -Xcompiler -fPIC -arch=sm_21

LIBS = -lnetcdf_c++ -lcudart

SOURCEDIR = src
CUDA_SOURCEDIR = src_cuda
BUILDDIR = build
OUTLIBPATH = lib
INSTALLDIR = 

SOURCES = $(wildcard $(SOURCEDIR)/*.cpp)
OBJECTS = $(patsubst $(SOURCEDIR)/%.cpp, $(BUILDDIR)/%.o, $(SOURCES))
CUDA_SOURCES = $(wildcard $(CUDA_SOURCEDIR)/*.cu)
CUDA_OBJECTS = $(patsubst $(CUDA_SOURCEDIR)/%.cu, $(BUILDDIR)/%.cu_o, $(CUDA_SOURCES))

all: dir $(TARGET)

dir:
	mkdir -p $(BUILDDIR)

$(TARGET): $(OBJECTS) $(CUDA_OBJECTS)
	g++ -shared $(LIBPATH) $(LDFLAGS) -o $(OUTLIBPATH)/$(TARGET).so.$(VERSION) $(OBJECTS) $(CUDA_OBJECTS) $(LIBS)

$(OBJECTS): $(BUILDDIR)/%.o : $(SOURCEDIR)/%.cpp
	g++ -c $(CPPFLAGS) $(INCPATH) $< -o $@ 

$(CUDA_OBJECTS): $(BUILDDIR)/%.cu_o : $(CUDA_SOURCEDIR)/%.cu
	/usr/local/cuda/bin/nvcc -c $(CUDAFLAGS) $(INCPATH) $< -o $@ 

install:
	cp $(OUTLIBPATH)/$(TARGET).so.$(VERSION) $(INSTALLDIR)
	
clean:
	rm -f $(BUILDDIR)/*.o $(BUILDDIR)/*.cu_o $(OUTLIBPATH)/$(TARGET)*



