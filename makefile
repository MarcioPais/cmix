CC = g++
CFLAGS = -std=c++11 -Wall -c
LFLAGS = -std=c++11 -Wall

OBJS = build/preprocessor.o build/dictionary.o build/encoder.o build/decoder.o build/predictor.o build/sigmoid.o build/mixer-input.o build/mixer.o build/byte-mixer.o build/byte-model.o build/sse.o build/context-manager.o build/direct.o build/direct-hash.o build/indirect.o build/nonstationary.o build/run-map.o build/byte-run.o build/match.o build/ppmd.o build/bracket.o build/paq8.o build/paq8hp.o build/bracket-context.o build/context-hash.o build/sparse.o build/lstm.o build/lstm-layer.o build/indirect-hash.o build/interval.o build/interval-hash.o build/bit-context.o build/combined-context.o

all: CFLAGS += -Ofast
all: LFLAGS += -Ofast
all: build cmix

debug: CFLAGS += -ggdb
debug: LFLAGS += -ggdb
debug: build cmix

cmix: $(OBJS) src/runner.cpp
	$(CC) $(LFLAGS) $(OBJS) src/runner.cpp -o cmix

build/dictionary.o: src/preprocess/dictionary.h src/preprocess/dictionary.cpp
	$(CC) $(CFLAGS) src/preprocess/dictionary.cpp -o build/dictionary.o

build/preprocessor.o: src/preprocess/preprocessor.h src/preprocess/preprocessor.cpp src/predictor.h src/preprocess/dictionary.h
	$(CC) $(CFLAGS) src/preprocess/preprocessor.cpp -o build/preprocessor.o

build/encoder.o: src/coder/encoder.h src/coder/encoder.cpp src/predictor.h
	$(CC) $(CFLAGS) src/coder/encoder.cpp -o build/encoder.o

build/decoder.o: src/coder/decoder.h src/coder/decoder.cpp src/predictor.h
	$(CC) $(CFLAGS) src/coder/decoder.cpp -o build/decoder.o

build/predictor.o: src/predictor.h src/predictor.cpp src/mixer/mixer-input.h src/mixer/byte-mixer.h src/mixer/mixer.h src/mixer/sse.h src/models/model.h src/models/byte-model.h src/models/direct.h src/models/direct-hash.h src/models/indirect.h src/models/byte-run.h src/models/match.h src/models/bracket.h src/models/ppmd.h src/models/paq8.h src/models/paq8hp.h src/context-manager.h src/contexts/context-hash.h src/contexts/bracket-context.h src/contexts/sparse.h src/contexts/interval.h src/contexts/interval-hash.h src/contexts/indirect-hash.h src/contexts/bit-context.h src/mixer/sigmoid.h
	$(CC) $(CFLAGS) src/predictor.cpp -o build/predictor.o

build/sigmoid.o: src/mixer/sigmoid.h src/mixer/sigmoid.cpp
	$(CC) $(CFLAGS) src/mixer/sigmoid.cpp -o build/sigmoid.o

build/mixer-input.o: src/mixer/mixer-input.h src/mixer/mixer-input.cpp src/mixer/sigmoid.h
	$(CC) $(CFLAGS) src/mixer/mixer-input.cpp -o build/mixer-input.o

build/byte-mixer.o: src/models/byte-model.h src/mixer/byte-mixer.h src/mixer/byte-mixer.cpp src/mixer/lstm.h
	$(CC) $(CFLAGS) src/mixer/byte-mixer.cpp -o build/byte-mixer.o

build/byte-model.o: src/models/byte-model.h src/models/byte-model.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/byte-model.cpp -o build/byte-model.o

build/mixer.o: src/mixer/mixer.h src/mixer/mixer.cpp src/mixer/sigmoid.h
	$(CC) $(CFLAGS) src/mixer/mixer.cpp -o build/mixer.o

build/sse.o: src/mixer/sse.h src/mixer/sse.cpp
	$(CC) $(CFLAGS) src/mixer/sse.cpp -o build/sse.o

build/context-manager.o: src/context-manager.h src/context-manager.cpp src/contexts/context.h src/contexts/bit-context.h src/states/nonstationary.h src/states/run-map.h
	$(CC) $(CFLAGS) src/context-manager.cpp -o build/context-manager.o

build/direct.o: src/models/direct.h src/models/direct.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/direct.cpp -o build/direct.o

build/direct-hash.o: src/models/direct-hash.h src/models/direct-hash.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/direct-hash.cpp -o build/direct-hash.o

build/indirect.o: src/models/indirect.h src/models/indirect.cpp src/states/state.h src/models/model.h
	$(CC) $(CFLAGS) src/models/indirect.cpp -o build/indirect.o

build/byte-run.o: src/models/byte-run.h src/models/byte-run.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/byte-run.cpp -o build/byte-run.o

build/match.o: src/models/match.h src/models/match.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/match.cpp -o build/match.o

build/lstm.o: src/mixer/lstm.h src/mixer/lstm.cpp src/mixer/lstm-layer.h
	$(CC) $(CFLAGS) src/mixer/lstm.cpp -o build/lstm.o

build/lstm-layer.o: src/mixer/lstm-layer.h src/mixer/lstm-layer.cpp src/mixer/sigmoid.h
	$(CC) $(CFLAGS) src/mixer/lstm-layer.cpp -o build/lstm-layer.o

build/bracket.o: src/models/bracket.h src/models/bracket.cpp src/models/byte-model.h
	$(CC) $(CFLAGS) src/models/bracket.cpp -o build/bracket.o

build/ppmd.o: src/models/ppmd.h src/models/ppmd.cpp src/models/byte-model.h
	$(CC) $(CFLAGS) src/models/ppmd.cpp -o build/ppmd.o

build/paq8.o: src/models/paq8.h src/models/paq8.cpp src/models/model.h src/preprocess/preprocessor.h
	$(CC) $(CFLAGS) src/models/paq8.cpp -o build/paq8.o

build/paq8hp.o: src/models/paq8hp.h src/models/paq8hp.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/paq8hp.cpp -o build/paq8hp.o

build/nonstationary.o: src/states/nonstationary.h src/states/nonstationary.cpp src/states/state.h
	$(CC) $(CFLAGS) src/states/nonstationary.cpp -o build/nonstationary.o

build/run-map.o: src/states/run-map.h src/states/run-map.cpp src/states/state.h
	$(CC) $(CFLAGS) src/states/run-map.cpp -o build/run-map.o

build/bracket-context.o: src/contexts/bracket-context.h src/contexts/bracket-context.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/bracket-context.cpp -o build/bracket-context.o

build/context-hash.o: src/contexts/context-hash.h src/contexts/context-hash.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/context-hash.cpp -o build/context-hash.o

build/indirect-hash.o: src/contexts/indirect-hash.h src/contexts/indirect-hash.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/indirect-hash.cpp -o build/indirect-hash.o

build/interval.o: src/contexts/interval.h src/contexts/interval.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/interval.cpp -o build/interval.o

build/interval-hash.o: src/contexts/interval-hash.h src/contexts/interval-hash.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/interval-hash.cpp -o build/interval-hash.o

build/sparse.o: src/contexts/sparse.h src/contexts/sparse.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/sparse.cpp -o build/sparse.o

build/bit-context.o: src/contexts/bit-context.h src/contexts/bit-context.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/bit-context.cpp -o build/bit-context.o

build/combined-context.o: src/contexts/combined-context.h src/contexts/combined-context.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/combined-context.cpp -o build/combined-context.o

build:
	mkdir -p build/

clean:
	rm -f -r build/* cmix
