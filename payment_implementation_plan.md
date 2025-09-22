# Payment Implementation Plan

This document outlines the steps to address the missing features, improvements, and bug fixes identified in the payment implementation analysis.

## 1. Backend (Laravel) Improvements

### 1.1 Refactor `PaymentRecordController` Validation Rule
**File:** `Shego admin/app/Http/Controllers/PaymentRecordController.php`
**Description:** The `payment_method` validation rule is overly long and contains duplicate entries. This will be refactored to use a more concise and maintainable approach, possibly by fetching allowed payment methods dynamically or using a custom validation rule.
**Steps:**
1.  Extract the list of allowed payment methods into a configuration or an enum.
2.  Update the `payment_method` validation rule to reference this centralized list.

### 1.2 Implement Admin Gateway Configuration UI
**Description:** Create an administrative interface to manage payment gateways. This UI will allow administrators to enable/disable gateways, set their priority, and configure test/live modes and API keys securely.
**Steps:**
1.  Create necessary routes and views for the admin panel.
2.  Develop a form to input and update gateway configurations (name, status, priority, test/live keys, mode).
3.  Implement logic to securely store API keys (e.g., in `.env` or encrypted in the database).
4.  Ensure the UI reflects the current status and configuration of each gateway.

## 2. Frontend (Flutter) Improvements and Bug Fixes

### 2.1 Fix Critical Bug in `CardPaymentScreen`
**File:** `Shego user app/lib/features/payment/screens/card_payment_screen.dart`
**Description:** The `_processPayment` method is not passing the collected card details to the `_paymentController.paymentSubmit` method, which is essential for processing payments.
**Steps:**
1.  Modify the `_processPayment` method to include `card_data` in the `paymentSubmit` call.
2.  Ensure the `PaymentController` is updated to accept and forward this `card_data` to the backend.

### 2.2 Display Supported Card Types in `CardPaymentScreen`
**File:** `Shego user app/lib/features/payment/screens/card_payment_screen.dart`
**Description:** Enhance the `CardPaymentScreen` to visually indicate the supported card types (e.g., Visa, Mastercard) to the user.
**Steps:**
1.  Add UI elements (e.g., icons) to display supported card types.
2.  Implement logic to dynamically show/hide card types based on the active payment gateway's capabilities (if available from backend).

### 2.3 Integrate `SavedCardsWidget` with Backend
**File:** `Shego user app/lib/features/payment/widgets/saved_cards_widget.dart`
**Description:** The `SavedCardsWidget` currently uses mock data. It needs to be integrated with the backend to fetch and display the user's actual saved cards.
**Steps:**
1.  Implement an API call in the `PaymentController` to fetch saved cards for the authenticated user.
2.  Update `SavedCardsWidget` to use the data from the `PaymentController` instead of mock data.
3.  Handle loading states and error conditions for fetching cards.

### 2.4 Implement Default Card Selection in `SavedCardsWidget`
**File:** `Shego user app/lib/features/payment/widgets/saved_cards_widget.dart`
**Description:** Add functionality for users to select a default card for future payments.
**Steps:**
1.  Add UI elements (e.g., a radio button or a "Set as Default" action) to allow users to mark a card as default.
2.  Implement an API call to update the `is_default` flag for the selected card in the backend.
3.  Ensure the UI reflects the currently selected default card.

### 2.5 Implement Remove/Edit Card Options in `SavedCardsWidget`
**File:** `Shego user app/lib/features/payment/widgets/saved_cards_widget.dart`
**Description:** Provide options for users to remove or edit their saved cards.
**Steps:**
1.  Add UI elements (e.g., icons or buttons) for "Remove" and "Edit" actions next to each saved card.
2.  Implement API calls in the `PaymentController` to delete or update card details in the backend.
3.  Add confirmation dialogs for card removal.

### 2.6 Implement Transaction History Screen
**Description:** Develop a screen to display the user's transaction history.
**Steps:**
1.  Create a new Flutter screen for transaction history.
2.  Implement API calls to fetch transaction records from the backend.
3.  Display transaction details, including branded messages (company name, not gateway names) and icons for payment types (wallet, card, gift card).

### 2.7 Implement UI Enhancements
**Description:** Improve the user experience with smooth animations and proper error messages.
**Steps:**
1.  Review `CardPaymentScreen` and other payment-related screens for animation opportunities (e.g., card entry, loading states).
2.  Ensure error messages are user-friendly and provide actionable feedback (e.g., "Card declined" instead of raw gateway errors).

## 3. Update `payment_implementation_todo.md`
**File:** `payment_implementation_todo.md`
**Description:** Update the `payment_implementation_todo.md` file to accurately reflect the current progress and the planned next steps.
**Steps:**
1.  Review all checked/unchecked items against the current state of the codebase.
2.  Adjust the progress percentages for Backend, Frontend, Testing, and Admin sections.
3.  Add new items or modify existing ones to align with this implementation plan.
