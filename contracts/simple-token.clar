;; Simple Token Contract
;; A basic token implementation with mint and transfer functionality

(define-constant CONTRACT_OWNER tx-sender)
(define-constant TOKEN-SYMBOL "STKN")
(define-constant TOKEN-NAME "Simple Token")
(define-constant DECIMALS u8)

;; Data maps
(define-map balances principal uint)
(define-map allowances (tuple (owner principal) (spender principal)) uint)

;; No events in this version - using print statements instead

;; Public functions

;; Get token balance for a principal
(define-public (get-balance (owner principal))
  (ok (default-to u0 (map-get? balances owner)))
)

;; Get allowance for a spender
(define-public (get-allowance (owner principal) (spender principal))
  (ok (default-to u0 (map-get? allowances (tuple (owner owner) (spender spender)))))
)

;; Transfer tokens from sender to recipient
(define-public (transfer (recipient principal) (amount uint))
  (let ((sender tx-sender))
    (if (and (is-eq sender recipient) false)
      (err u1) ;; Cannot transfer to self
      (let ((sender-balance (default-to u0 (map-get? balances sender))))
        (if (< sender-balance amount)
          (err u2) ;; Insufficient balance
          (begin
            (map-set balances sender (- sender-balance amount))
            (map-set balances recipient (+ (default-to u0 (map-get? balances recipient)) amount))
            (ok true)
          )
        )
      )
    )
  )
)

;; Transfer tokens using allowance (for approved spenders)
(define-public (transfer-from (owner principal) (recipient principal) (amount uint))
  (let ((sender tx-sender))
    (if (is-eq owner recipient)
      (err u1) ;; Cannot transfer to self
      (let ((allowance (default-to u0 (map-get? allowances (tuple (owner owner) (spender sender)))))
            (owner-balance (default-to u0 (map-get? balances owner))))
        (if (< allowance amount)
          (err u3) ;; Insufficient allowance
          (if (< owner-balance amount)
            (err u2) ;; Insufficient balance
            (begin
              (map-set allowances (tuple (owner owner) (spender sender)) (- allowance amount))
              (map-set balances owner (- owner-balance amount))
              (map-set balances recipient (+ (default-to u0 (map-get? balances recipient)) amount))
              (ok true)
            )
          )
        )
      )
    )
  )
)

;; Approve a spender to spend tokens on behalf of the owner
(define-public (approve (spender principal) (amount uint))
  (let ((owner tx-sender))
    (map-set allowances (tuple (owner owner) (spender spender)) amount)
    (ok true)
  )
)

;; Mint new tokens (only contract owner can mint)
(define-public (mint (recipient principal) (amount uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (begin
      (map-set balances recipient (+ (default-to u0 (map-get? balances recipient)) amount))
      (ok true)
    )
    (err u4) ;; Only owner can mint
  )
)

;; Get token metadata
(define-public (get-token-metadata)
  (ok (tuple 
    (name "Simple Token")
    (symbol "STKN")
    (decimals DECIMALS)
    (total-supply (get-total-supply))
  ))
)

;; Private helper function to calculate total supply
;; Note: This is a simplified version - in a real implementation you'd track total supply separately
(define-private (get-total-supply)
  u0 ;; For simplicity, returning 0 - in production you'd track this in a separate variable
)
