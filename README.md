# Simple Token Smart Contract

A basic token implementation in Clarity that can be deployed on Stacks testnet.

## Features

- **Minting**: Only the contract owner can mint new tokens
- **Transfer**: Users can transfer tokens to other addresses
- **Approval System**: Users can approve others to spend tokens on their behalf
- **Balance Tracking**: Track token balances for all users
- **Events**: Emit events for transfers, mints, and approvals

## Contract Functions

### Public Functions

- `(get-balance (owner principal))` - Get token balance for a user
- `(get-allowance (owner principal) (spender principal))` - Get allowance for a spender
- `(transfer (recipient principal) (amount uint))` - Transfer tokens to another address
- `(transfer-from (owner principal) (recipient principal) (amount uint))` - Transfer tokens using allowance
- `(approve (spender principal) (amount uint))` - Approve a spender to spend tokens
- `(mint (recipient principal) (amount uint))` - Mint new tokens (owner only)
- `(get-token-metadata)` - Get token information (name, symbol, decimals, total supply)

## Error Codes

- `u1` - Cannot transfer to self
- `u2` - Insufficient balance
- `u3` - Insufficient allowance
- `u4` - Only owner can mint

## Deployment Instructions

### Prerequisites

1. Install Clarinet: https://docs.hiro.so/clarinet/getting-started
2. Get testnet STX tokens from the faucet: https://faucet.hiro.so/

### Setup

1. **Configure your testnet account**:
   Edit `settings/Testnet.toml` and replace `<YOUR PRIVATE TESTNET MNEMONIC HERE>` with your actual testnet mnemonic.

2. **Test the contract locally**:
   ```bash
   clarinet test
   ```

3. **Deploy to testnet**:
   ```bash
   clarinet deploy --network testnet
   ```

### Usage Examples

After deployment, you can interact with the contract using:

```bash
# Get your balance
clarinet contract call --network testnet simple-token get-balance --args <your-address>

# Mint tokens (as deployer)
clarinet contract call --network testnet simple-token mint --args <recipient-address> u1000

# Transfer tokens
clarinet contract call --network testnet simple-token transfer --args <recipient-address> u100

# Approve spender
clarinet contract call --network testnet simple-token approve --args <spender-address> u200

# Get token metadata
clarinet contract call --network testnet simple-token get-token-metadata
```

## Contract Details

#### Contract Identifier: ST1TVDG8AZSBZXSZRXXCVM1NHDG37QJKDEEVXHTNW.simple-token
#### Contract Screenshot: <img width="1710" height="1107" alt="Screenshot 2025-08-24 at 2 30 16 PM" src="https://github.com/user-attachments/assets/d9701d03-eb14-426d-891f-9858fae7a8ae" />


## Security Notes

- Only the contract owner can mint new tokens
- All transfers check for sufficient balance
- Approval system prevents unauthorized spending
- Events are emitted for all state changes

## Testing

Run the test suite to verify contract functionality:

```bash
clarinet test
```

The tests cover:
- Basic minting and transfer functionality
- Approval and transfer-from operations
- Error cases (insufficient balance, unauthorized minting)
- Balance tracking accuracy
