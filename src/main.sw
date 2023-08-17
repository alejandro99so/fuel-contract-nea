contract;
use std::storage::StorageVec;
use std::storage::StorageMap;

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

abi Counter {
    #[storage(read, write)]
    fn increment();

    #[storage(read)]
    fn count() -> u64;
}

impl Counter for Contract {
    #[storage(read)]
    fn count() -> u64 {
        storage.counter
    }

    #[storage(read, write)]
    fn increment() {
        storage.counter = storage.counter + 1
    }
}