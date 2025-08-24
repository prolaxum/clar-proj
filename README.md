# Simple Token Smart Contract

Short description
A minimal ERC-20-like token implemented in Clarity for the Stacks blockchain. Supports owner-only minting, transfers, approvals, and balance tracking. Designed for deployment on Stacks testnet.

Tech stack
- Smart contract language: Clarity
- Tooling: Clarinet (local testing & deployment)
- Network: Stacks Testnet / Mainnet
- Language/Platform: Stacks blockchain

Repository structure
project-name/
├── contracts/
│   └── simple-token.clar
├── tests/
│   └── simple-token-tests.clar
├── frontend/ (optional)
│   └── ...
├── README.md
├── contract-address.txt
└── LICENSE (optional)

Setup instructions

Prerequisites
1. Install Clarinet: https://docs.hiro.so/clarinet/getting-started
2. Install Node.js (if you plan to use a frontend or scripts)
3. Obtain testnet STX from the Hiro faucet: https://faucet.hiro.so/

Local setup
1. Clone the repository:
   four backticksbash
   git clone <repo-url>
   cd clar-proj
   four backticks

2. Configure accounts for testnet:
   - Edit settings/Testnet.toml and replace <YOUR PRIVATE TESTNET MNEMONIC HERE> with your mnemonic.

3. Run tests locally:
   four backticksbash
   clarinet test
   four backticks

Deployment (testnet)
four backticksbash
clarinet deploy --network testnet
four backticks

Smart contract address (deployed on testnet)
Contract identifier (example): ST1TVDG8AZSBZXSZRXXCVM1NHDG37QJKDEEVXHTNW.simple-token
Save the deployed address in contract-address.txt after deployment.

How to use the project (common commands)
- Get balance:
  four backticksbash
  clarinet contract call --network testnet simple-token get-balance --args "<principal>"
  four backticks

- Mint tokens (owner only):
  four backticksbash
  clarinet contract call --network testnet simple-token mint --args "<recipient-principal>" u1000
  four backticks

- Transfer tokens:
  four backticksbash
  clarinet contract call --network testnet simple-token transfer --args "<recipient-principal>" u100
  four backticks

- Approve spender:
  four backticksbash
  clarinet contract call --network testnet simple-token approve --args "<spender-principal>" u200
  four backticks

- Transfer-from (using allowance):
  four backticksbash
  clarinet contract call --network testnet simple-token transfer-from --args "<owner-principal>" "<recipient-principal>" u50
  four backticks

Contract functions (summary)
- get-balance (owner principal) -> uint
- get-allowance (owner principal) (spender principal) -> uint
- transfer (recipient principal) (amount uint) -> (ok | err u*)
- transfer-from (owner principal) (recipient principal) (amount uint) -> (ok | err u*)
- approve (spender principal) (amount uint) -> (ok | err u*)
- mint (recipient principal) (amount uint) -> (ok | err u*) — owner only
- get-token-metadata -> {name, symbol, decimals, total-supply}

Error codes
- u1 — Cannot transfer to self
- u2 — Insufficient balance
- u3 — Insufficient allowance
- u4 — Only owner can mint

Team members
- Replace with project contributors (e.g., Yash)

Screenshots / Demo
- Optional: include screenshots or a demo video link. Example screenshot present in the repository assets.

Quality requirements (checklist)
- Code is clean and commented (add comments in Clarity contract explaining logic).
- Tests present and passing (run clarinet test).
- Contract deployed — add the deployed address to contract-address.txt.
- README explains how to run and use the project.

Notes
- This README follows the submission template. Update placeholders (mnemonic, repo URL, contributors, and deployed address) before final submission.
- Keep private keys and mnemonics out of the repository.
