contract;
use std::storage::StorageVec;
use std::storage::StorageMap;
use std::{
    auth::msg_sender,
    token::transfer,
};

struct ReceiverStruct {
    receiver: Identity,
    amount: u64,
}

storage {
    owner: Identity = Identity::Address(Address::from(0x0000000000000000000000000000000000000000000000000000000000000000)),
    counter: u64 = 0,
    totalTxs: u64 = 0,
    balanceOwner: u64 = 0,
    frogs: StorageVec<Identity> = StorageVec {},
    tranfers: StorageMap<Identity, ReceiverStruct> = StorageMap {},  
}

abi Escrow {
    #[storage(read, write)]
    fn deposit(_amount: u64, _receiver: Identity);

    #[storage(read)]
    fn count() -> u64;
}

impl Escrow for Contract {
    #[storage(read)]
    fn count() -> u64 {
        storage.counter
    }

    #[storage(read, write)]
    fn deposit(_amount: u64, _receiver: Identity) {
        let mut _valueTransfer = _amount;
        if (storage.totalTxs > 100 && storage.totalTxs <1000) {
            _valueTransfer = _amount*10005/10000;
            storage.balanceOwner = storage.balanceOwner + _amount*5/10000;
        } else if (storage.totalTxs > 1000) {
            _valueTransfer = _amount*1001/1000;
            storage.balanceOwner = storage.balanceOwner + _amount/1000;
        }
        let new_reception = receiverStruct {
            receiver: _receiver,
            amount: _amount
        }
        storage.tranfers[msg_sender().unwrap()] = new_reception;
        storage.counter = storage.counter + 1
    }
}