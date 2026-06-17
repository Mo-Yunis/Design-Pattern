///=============================================================================
///-- Basic Factory Pattern Structure
///=============================================================================
// ┌─────────────────────────────────────────────────────────────────┐
// │                         CLIENT CODE                             │
// │                   (Your Widget / Business Logic)                │
// └───────────────────────────────┬─────────────────────────────────┘
//                                 │
//                                 │ "I want a 'credit' payment"
//                                 ▼
// ┌─────────────────────────────────────────────────────────────────┐
// │                      PAYMENT FACTORY                            │
// │                   ┌─────────────────────┐                       │
// │                   │  create(type)       │                       │
// │                   │                     │                       │
// │                   │  if type == "credit"│                       │
// │                   │    return CreditCard│                       │
// │                   │  if type == "paypal"│                       │
// │                   │    return PayPal    │                       │
// │                   └─────────────────────┘                       │
// └─────────┬────────────────────┬─────────────────────┬────────────┘
//           │                    │                     │
//           ▼                    ▼                     ▼
// ┌───────────────────┐ ┌───────────────────┐ ┌───────────────────┐
// │   CreditCard      │ │     PayPal        │ │   CryptoPayment   │
// │   Payment         │ │    Payment        │ │   (future)        │
// ├───────────────────┤ ├───────────────────┤ ├───────────────────┤
// │ + pay(amount)     │ │ + pay(amount)     │ │ + pay(amount)     │
// └───────────────────┘ └───────────────────┘ └───────────────────┘
//          ▲                     ▲                     ▲
//          └─────────────────────┼─────────────────────┘
//                                │
//                      ┌───────────────────┐
//                      │  <<interface>>    │
//                      │  PaymentMethod    │
//                      ├───────────────────┤
//                      │ + pay(amount)     │
//                      └───────────────────┘
///=============================================================================
/// --Visual Flow
///=============================================================================
// ┌─────────────────────────────────────────────────────────────────────────┐
// │                         YOUR APP GROWS                                  │
// │                                                                         │
// │  Day 1: Only CreditCard and PayPal                                      │
// │  Day 30: Need to add CryptoPayment                                      │
// │  Day 60: Need to add BankTransfer                                       │
// │  Day 90: Need to add BuyNowPayLater                                     │
// └─────────────────────────────────────────────────────────────────────────┘
//                                     │
//                                     ▼
// ┌─────────────────────────────────────────────────────────────────────────┐
// │                      WITHOUT FACTORY PATTERN                            │
// │                                                                         │
// │  Everywhere you create payments:                                        │
// │                                                                         │
// │  if (type == 'credit') new CreditCardPayment()                          │
// │  else if (type == 'paypal') new PayPalPayment()                         │
// │  else if (type == 'crypto') new CryptoPayment()   ← ADD THIS IN 50 files│
// │  else if (type == 'bank') new BankTransfer()      ← ADD THIS IN 50 files│
// │                                                                         │
// │  ❌ You have to modify 50+ files each time you add a new payment type   │
// └─────────────────────────────────────────────────────────────────────────┘
//                                     │
//                                     ▼
// ┌─────────────────────────────────────────────────────────────────────────┐
// │                      WITH FACTORY PATTERN                               │
// │                                                                         │
// │  Only ONE place to change:                                              │
// │                                                                         │
// │  class PaymentFactory {                                                 │
// │    static create(type) {                                                │
// │      switch(type) {                                                     │
// │        case 'credit': return CreditCardPayment();                       │
// │        case 'paypal': return PayPalPayment();                           │
// │        case 'crypto': return CryptoPayment();    ← ADD HERE ONLY        │
// │        case 'bank': return BankTransfer();       ← ADD HERE ONLY        │
// │      }                                                                  │
// │    }                                                                    │
// │  }                                                                      │
// │                                                                         │
// │  ✅ Modify ONLY 1 file when adding new payment types                    │
// └─────────────────────────────────────────────────────────────────────────┘
