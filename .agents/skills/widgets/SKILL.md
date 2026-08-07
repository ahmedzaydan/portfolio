---
name: widgets
description: Instruction to create new widgets or screen
---

# Rules:

## Screens & Widgets
- For every screen, create a separate file in `screens/` named `<feature>_<screen>_screen.dart`
- For every widget, create a separate file in `widgets/` named `<widget_name>.dart`

## Localization
- Any translation value should be accessed only by `context.tr.<key>`
- Values should be added to all `.arb` files in `assets/localization`

## Colors
- Any color value should be accessed only by `context.colorManager.<key>`

## Text Styles
- Any text style value should be accessed only by:

```dart
context.textStyle.<key>.copyWith(color: context.colorManager.<color>)
```

## Assets

- Any asset path should be accessed only by `AssetsManager.<key>`

## Components

- Any buttons should be created by `CustomElevatedButton` (ask user every time)
- Any text field should be created by `CustomTextFormField` (ask user every time)

## BlocConsumer Listener
- Always extract the listener body into a **private method** named `_listener` with the same signature and assign it to the `listener` parameter — never write logic inline.

## Showing Toasts

- Always use `context.showSuccess/ErrorToast(message)` to show toasts

## State Status Checks
- When checking for status in the UI, always use getters in `core/enums/state_enum.dart`:
  ```dart
  profileState.getProfileStatus.isSuccess/isLoading/isFailure
  ```
- Use the **extension getters** on `StateEnum?` defined in `lib/core/enums/state_enum.dart` — they already handle null safely, so never add a null check before them.
  ```dart
  // ✅ Correct — null-safe getters, no explicit null check needed
  if (state.getProfileStatus.isSuccess) { ... }

  // ❌ Wrong — redundant null check or raw enum comparison
  if (state.getProfileStatus != null && state.getProfileStatus == StateEnum.success) { ... }
  ```
- **always** Prefer `GenericBlocBuilder` / `GenericBlocConsumer` from `core/widgets/states/` for standard loading/error/success patterns.

## General Rules
- **always** Keep files readable and maintainable by following SOLID, KISS, DRY and YAGNI principles.
- **always** Prefer clarity over cleverness
- **always** Small files and functions; files and functions must stay small and focused, avoid large classes and overly complex files.
- **always** Comments only when necessary
- Prefer efficient widget composition and separation to minimize rebuild scope.
- Ask or clearly state assumptions if something is unclear.
- Reuse existing logic when available.
- Write self-documenting code with meaningful names
- Don't introduce unnecessary abstraction
- Don't over-engineer solutions
- Identify and fix the root cause, not just symptoms
- Don't apply superficial fixes
- Understand the problem fully before implementing solutions
- Make the smallest possible change that solves the problem
- Don't refactor unrelated code unless explicitly requested
- Always consider security implications
- Act as a senior engineer partner, not just a task executor
- Before finishing any task, verify:
  1. No performance regressions introduced
  2. No security risks introduced
