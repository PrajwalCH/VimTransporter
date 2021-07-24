# author      : Prajwal Chapagain (pub.cx00@gmail.com)
# created at  : Tuesday Jul 20, 2021 13:00:19 NPT
# license     : MIT

DEBUG=0

STD=-std=c11
WARN=-Wall -W -Werror -Wextra
OPTIMIZE=-O2
DEBUG_FLAGS=-g

CC=clang
CFLAGS=$(STD) -MMD

ifeq ($(DEBUG), 1)
	CFLAGS += $(DEBUG_FLAGS) $(WARN) -DDEBUG
else
	CFLAGS += $(OPTIMIZE) -DNDEBUG
endif

BIN_DIR=./bin
BUILD_DIR=./build
INCLUDE_DIR=./include
SRC_DIR=./src

ifneq (,$(wildcard $(INCLUDE_DIR)))
    CFLAGS += -I$(INCLUDE_DIR)
endif

SRCS=$(wildcard $(SRC_DIR)/*.c)
OBJS=$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRCS))
DEPS=$(patsubst %.o, %.d, $(OBJS))

TARGET=server

LIBS=

$(BIN_DIR)/$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ 

-include ($(DEPS))

.PHONY: clean
clean:
	$(RM) $(BIN_DIR)/* $(BUILD_DIR)/*


