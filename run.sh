CONFIG="" # path to config
DATA_PATH="" # global path to data (should look like ...data/ without the corpus)
WEIGHTS_PATH="" # global path to weight storage
PRETRAINING=True

# args
# config data_path weights_path pretraining

torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py $CONFIG $DATA_PATH $WEIGHTS_PATH $PRETRAINING

languages=("eng" "span")
paradigms=("syl" "bpe" "morf")
data_path=""
out_path=""
cross_val_counter=(0,1,2,3,4,5,6,7,8,9)

for lang in "${languages[@]}"; do
  for p in "${paradigms[@]}"; do
    for c in ${cross_val_counter[@]}; do
      config="${lang}_${p}_config.json"
      torchrun --standalone --nproc_per_node=1 modded_train_gpt2.py "$config" "$data_path" "$out_path" $c
      done
  done
done