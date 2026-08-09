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
- If you want to use opaticy, use color.withCustomOpacity

## Text Styles
- Any text style value should be accessed only by:

```dart
context.textStyle.<key>.copyWith(color: context.colorManager.<color>)
```

## Spacing & Sizing
- Any spacing values, height, width, padding, margin, radius, or widget sizes should use the extensions defined in `utils/size_manager.dart`.
- Use `.w` for width/horizontal spacing, `.h` for height/vertical spacing, and `.r` for border radius.

## Assets

- Any asset path should be accessed only by `AssetsManager.<key>`


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
