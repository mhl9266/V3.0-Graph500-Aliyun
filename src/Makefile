CFLAGS = -Drestrict=__restrict__ -O3 -DGRAPH_GENERATOR_MPI -DREUSE_CSR_FOR_VALIDATION -I../aml -g
LDFLAGS += -L/usr/lib/x86_64-linux-gnu

MPICC = /usr/bin/mpicc

all: graph500_reference_bfs_sssp graph500_reference_bfs graph500_custom_bfs graph500_custom_bfs_sssp

GENERATOR_SOURCES = ../generator/graph_generator.c ../generator/make_graph.c ../generator/splittable_mrg.c ../generator/utils.c
SOURCES = main.c utils.c validate.c ../aml/aml.c
HEADERS = common.h csr_reference.h bitmap_reference.h


graph500_reference_bfs_sssp: bfs_reference.c $(SOURCES) $(HEADERS) $(GENERATOR_SOURCES) csr_reference.c sssp_reference.c
	$(MPICC) $(CFLAGS) -DSSSP bfs_reference.c sssp_reference.c csr_reference.c $(SOURCES) $(GENERATOR_SOURCES) -o graph500_reference_bfs_sssp -lm -lpthread $(LDFLAGS)

graph500_reference_bfs: bfs_reference.c $(SOURCES) $(HEADERS) $(GENERATOR_SOURCES) csr_reference.c
	$(MPICC) $(CFLAGS) bfs_reference.c csr_reference.c $(SOURCES) $(GENERATOR_SOURCES) -o graph500_reference_bfs -lm -lpthread $(LDFLAGS)

graph500_custom_bfs: bfs_custom.c $(SOURCES) $(HEADERS) $(GENERATOR_SOURCES) csr_reference.c
	$(MPICC) $(CFLAGS) bfs_custom.c csr_reference.c $(SOURCES) $(GENERATOR_SOURCES) -o graph500_custom_bfs -lm -lpthread $(LDFLAGS)

graph500_custom_bfs_sssp: bfs_custom.c sssp_custom.c $(SOURCES) $(HEADERS) $(GENERATOR_SOURCES) csr_reference.c
	$(MPICC) $(CFLAGS) bfs_custom.c sssp_custom.c csr_reference.c $(SOURCES) $(GENERATOR_SOURCES) -o graph500_custom_bfs_sssp -lm -lpthread $(LDFLAGS)


clean:
	-rm -f graph500_*
