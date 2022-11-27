
;; billboard
;; 

;; constants
(define-constant err_stx_transfer u100)
(define-constant err_not_owner u101)

;; data maps and vars
(define-data-var billboard-message (string-utf8 500) u"hello world!" )
(define-data-var price uint u100)




;; private functions
;;

;; public functions
(define-read-only (get-billboard-message) 
   (var-get billboard-message)
)

(define-public (set-message (message (string-utf8 500)))
    (let ((cur-price (var-get price))
          (new-price (+ cur-price u10)))

        ;; pay the contract
        (unwrap! (stx-transfer? cur-price tx-sender (as-contract tx-sender)) (err err_stx_transfer))

        ;; update the billboard's message
        (var-set billboard-message message)

        ;; update the price
        (var-set price new-price)

        ;; return the updated price
        (ok new-price)
    )
)


(define-read-only (get-price) 
  (var-get price)
)

;;get contract stx balance
(define-public (stx-balance) 

 (ok (stx-get-balance (as-contract tx-sender)))

)


