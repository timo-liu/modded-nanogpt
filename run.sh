CONFIG="" # path to config
DATA_PATH="" # global path to data (should look like ...data/ without the corpus)
WEIGHTS_PATH="" # global path to weight storage
PRETRAINING=True

# args
# config data_path weights_path pretraining

torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py $CONFIG $DATA_PATH $WEIGHTS_PATH $PRETRAINING