import os
from dataclasses import dataclass
import json

# this config file will help me keep my head straight, I hope

@dataclass
class Config:
    # experimental properties configuration. This is more for recording, and will not generally impact training behavior
    language : str=""
    paradigm : str=""
    suffix : str=""
    # properties of the model that might actually impact training...
    d_model : int=None # model dimension. Roughly correlated with "learnable parameters"... AFAIK UPDATE
    num_heads : int=None # number of attention heads, loosely corresponds with "learnable linguistic features" UPDATE
    vocab_size: int=None # vocab size of the tokenizer. Pretty straightforward
    num_layers: int=None # number of layers... number of blocks... more means bigger yippee
    max_seq_len : int=None # max input sequence length, essentially max context window
    # modded nanogpt optimization specific parameters
    u_net_ledges : int=3 # how long are the "legs" of the value embedding skipping unet?
    eos_id : int=0 # what token id to use to align the documents?

    @classmethod
    def load(cls, config_path):
        assert os.path.exists(config_path), "Wrong path dumbass"
        with open(config_path, "r") as f:
            config = json.load(f)
        obj = cls()
        for k, v in config.items():
            if hasattr(obj, k):
                setattr(obj, k, v)
        return obj

    def assertions(self):
        """
        Applies some config level assertions that we know will break the model
        Returns:

        """
        assert u_net_ledges <= num_layers//2, "The u_net_ledges are going swaddle the num_layers, can't have the blankets smother the baby."
        assert d_model % num_heads == 0, "d_model must be divisible by num_heads"