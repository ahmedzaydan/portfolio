# Flutter Developer Portfolio — Design Specification
**Version:** 1.0  
**Target Platforms:** Web · Tablet · Mobile (Flutter)  
**Aesthetic:** Dark Tech / Cyberpunk — precision-engineered, not decorative

---

## Table of Contents
1. [Design Philosophy](#1-design-philosophy)
2. [Design Tokens](#2-design-tokens)
3. [Typography System](#3-typography-system)
4. [Spacing & Grid System](#4-spacing--grid-system)
5. [Breakpoints](#5-breakpoints)
6. [Scroll & Navigation Behavior](#6-scroll--navigation-behavior)
7. [Navigation Bar](#7-navigation-bar)
8. [Hero Section](#8-hero-section)
9. [About Section](#9-about-section)
10. [Education Section](#10-education-section)
11. [Experience Section](#11-experience-section)
12. [Projects Section](#12-projects-section)
13. [Skills Section](#13-skills-section)
14. [Footer](#14-footer)
15. [Shared Component Library](#15-shared-component-library)
16. [Animation Guidelines](#16-animation-guidelines)
17. [Flutter Implementation Notes](#17-flutter-implementation-notes)

---

## 1. Design Philosophy

**Subject:** A senior Flutter mobile developer seeking to stand out among template-heavy portfolios.  
**Audience:** Recruiters, potential clients, and fellow engineers.  
**Single Job of the Page:** Establish technical credibility and personality within 5 seconds.

**Aesthetic Direction:** The palette and dark-field speak to precision and depth — the visual language of an IDE at 2AM, not a marketing brochure. Every section should feel like looking at a beautifully crafted app, not a website *about* apps.

**Signature Element:** The hero profile image is encased in a continuously rotating dual-tone gradient ring (cyan → purple → cyan), rendered via a custom `CustomPainter`. This single animated element is the visual anchor of the entire portfolio. All other animations are scroll-triggered and additive — they do not compete with it.

**Design Rules:**
- One accent color per sentence of UI. Never both cyan and purple in the same component.
- Cards never have drop shadows. They use a subtle `1px` border with `outline` color (`#4A5568`) on hover transitions to cyan.
- Section headers always pair: a muted `labelSmall` eyebrow above a bold `headlineMedium` title.
- Gradient is used only for the signature ring and the hero name text. Everywhere else it is flat color.

---

## 2. Design Tokens

Derived directly from the provided `ThemeData`. Every value below maps 1:1 to the Dart constants.

### Color Palette

| Token Name              | Hex Value   | Role                                     |
|-------------------------|-------------|------------------------------------------|
| `primaryBg`             | `#080C14`   | Page scaffold background                 |
| `surface`               | `#0F1724`   | Navbar, section alternating backgrounds  |
| `card`                  | `#1A2336`   | All cards, timeline tracks, skill chips  |
| `cyan`                  | `#00D4F5`   | Primary accent: CTAs, active states, links, borders on focus |
| `purple`                | `#6C63FF`   | Secondary accent: badges, alternate highlights, gradient endpoint |
| `textPrimary`           | `#E8EDF5`   | H1–H3, body text, labels                 |
| `textSecondary`         | `#8B9BB4`   | Subtitles, descriptions, nav links       |
| `textMuted`             | `#4A5568`   | Card borders, dividers, timestamps       |
| `error`                 | `#CF6679`   | Form errors (not heavily used)           |

### Derived Semantic Colors (compute at runtime)

| Usage                        | Value                                         |
|------------------------------|-----------------------------------------------|
| Hero name gradient           | `LinearGradient([cyan, purple])`              |
| Signature ring gradient      | `SweepGradient([cyan, purple, cyan])`         |
| Card border (default)        | `#4A5568` at `1px`                            |
| Card border (hover/active)   | `#00D4F5` at `1px`                            |
| Section divider line         | `#1A2336` at `1px` height                     |
| Navbar blur tint             | `#080C14` at `90%` opacity                    |
| Skill chip background        | `#1A2336` with `#00D4F5` border at `1px`      |
| Store badge background       | `#0F1724` with rounded corners                |

---

## 3. Typography System

### Font Families

Use Google Fonts — declare both in `pubspec.yaml`:

| Role              | Family            | Rationale                                               |
|-------------------|-------------------|---------------------------------------------------------|
| Display / UI      | `Space Grotesk`   | Geometric, slightly technical, not overused in portfolios |
| Monospace / Chips | `JetBrains Mono`  | Reinforces developer identity; used for skill tags and code-like labels |

Override the `fontFamily` in `ThemeData` with `Space Grotesk`. Apply `JetBrains Mono` locally via `TextStyle(fontFamily: 'JetBrains Mono')` on skill chips and section eyebrows.

### Type Scale

| Style             | Size  | Weight       | Font            | Color           | Usage                          |
|-------------------|-------|--------------|-----------------|-----------------|--------------------------------|
| `displayLarge`    | 56sp  | Bold (700)   | Space Grotesk   | `textPrimary`   | Hero name (web only)           |
| `displayMedium`   | 40sp  | Bold (700)   | Space Grotesk   | `textPrimary`   | Hero name (tablet)             |
| `displaySmall`    | 32sp  | Bold (700)   | Space Grotesk   | `textPrimary`   | Hero name (mobile)             |
| `headlineLarge`   | 32sp  | Bold (700)   | Space Grotesk   | `textPrimary`   | (reserved / not used)          |
| `headlineMedium`  | 28sp  | SemiBold 600 | Space Grotesk   | `textPrimary`   | Section titles (web/tablet)    |
| `headlineSmall`   | 22sp  | SemiBold 600 | Space Grotesk   | `textPrimary`   | Section titles (mobile)        |
| `titleLarge`      | 20sp  | SemiBold 600 | Space Grotesk   | `textPrimary`   | Card headings, project names   |
| `titleMedium`     | 16sp  | Medium 500   | Space Grotesk   | `textSecondary` | Card subtitles, roles          |
| `titleSmall`      | 14sp  | Medium 500   | Space Grotesk   | `textSecondary` | Company names, durations       |
| `bodyLarge`       | 16sp  | Regular 400  | Space Grotesk   | `textPrimary`   | About section paragraphs       |
| `bodyMedium`      | 14sp  | Regular 400  | Space Grotesk   | `textSecondary` | Descriptions, bullet points    |
| `bodySmall`       | 12sp  | Regular 400  | Space Grotesk   | `textMuted`     | Timestamps, footnotes          |
| `labelLarge`      | 14sp  | Medium 500   | JetBrains Mono  | `textPrimary`   | Skill chip text                |
| `labelMedium`     | 12sp  | Medium 500   | JetBrains Mono  | `textSecondary` | Store badge text, nav links    |
| `labelSmall`      | 11sp  | Medium 500   | JetBrains Mono  | `cyan`          | Section eyebrows (e.g., `// about`) |

### Section Eyebrow Pattern

Every section uses this header structure:
```
// section_name          ← labelSmall, cyan, JetBrains Mono
Section Title            ← headlineMedium, textPrimary, Space Grotesk
──────── (cyan 40px line, 2px height, animates in from left on scroll)
```

---

## 4. Spacing & Grid System

### Base Unit
All spacing is a multiple of `8px`.

| Token    | Value | Usage                                        |
|----------|-------|----------------------------------------------|
| `xs`     | 4px   | Icon padding, tight chip padding             |
| `sm`     | 8px   | Internal card padding, icon gaps             |
| `md`     | 16px  | Default padding, list item gaps              |
| `lg`     | 24px  | Card padding, section internal gaps          |
| `xl`     | 32px  | Component group spacing                      |
| `xxl`    | 48px  | Section top/bottom padding (mobile)          |
| `xxxl`   | 80px  | Section top/bottom padding (desktop/tablet)  |

### Max Width Constraints

| Context             | Max Width  |
|---------------------|------------|
| Page content area   | `1200px`   |
| Section content     | `960px`    |
| Cards in grid       | `340px`    |
| Prose text (about)  | `680px`    |

### Column Grid

| Breakpoint | Columns | Gutter | Margin    |
|------------|---------|--------|-----------|
| Desktop    | 12      | 24px   | auto (centered to 1200px max) |
| Tablet     | 8       | 20px   | 32px each side |
| Mobile     | 4       | 16px   | 16px each side |

---

## 5. Breakpoints

```dart
// Use these constants throughout the app
class Breakpoints {
  static const double mobile  = 0;     // < 600
  static const double tablet  = 600;   // 600 – 1199
  static const double desktop = 1200;  // ≥ 1200
}
```

**Responsive strategy:** Use `LayoutBuilder` → `constraints.maxWidth` at the top-level page widget to switch between three layout trees. Do NOT use `MediaQuery` alone — wrap in `LayoutBuilder` for accurate render-box-aware sizing.

```dart
LayoutBuilder(builder: (context, constraints) {
  if (constraints.maxWidth >= 1200) return DesktopLayout();
  if (constraints.maxWidth >= 600)  return TabletLayout();
  return MobileLayout();
})
```

---

## 6. Scroll & Navigation Behavior

- The page is a **single-page scrollable** layout (`CustomScrollView` with `SliverList` or a `SingleChildScrollView`).
- Use a `ScrollController` passed down via an `InheritedWidget` or `Provider`.
- Each section is assigned a `GlobalKey` for programmatic scroll-to.
- Navigation items trigger `Scrollable.ensureVisible(context, duration: 600ms, curve: Curves.easeInOutCubic)`.
- On **desktop and tablet**, the page uses **sticky top navbar**.
- On **mobile**, the page uses a **hamburger → end drawer** pattern (no bottom nav bar — avoids competing with mobile OS gestures).
- Active nav item detection: track scroll position against each section's `RenderBox` offset and highlight the current section link in `cyan`.

---

## 7. Navigation Bar

### Visual Anatomy

```
┌─────────────────────────────────────────────────────────────────┐
│  [Initials Badge]  [name]           [About] [Edu] [Exp] [Projects] [Skills]  [Hire Me ▶]  │
└─────────────────────────────────────────────────────────────────┘
```

### Specs

| Property              | Value                                                        |
|-----------------------|--------------------------------------------------------------|
| Height                | `64px` (desktop/tablet), `56px` (mobile)                    |
| Background            | `#080C14` at `90%` opacity + `BackdropFilter(blur: 12)`      |
| Border bottom         | `1px solid #1A2336`                                          |
| Position              | `Positioned` sticky (Sliver or `Stack` + scroll listener)   |
| Elevation             | None — backdrop blur replaces elevation shadow               |
| Transition on scroll  | At `y > 80`: border bottom fades in, background deepens to `95%` opacity |

### Left: Brand Identity
- A small `Container` (32×32px, radius 8px) with a `SweepGradient` border (`cyan → purple`), containing the developer's initials in `labelLarge`/`JetBrains Mono`/`textPrimary`.
- Next to it: first name only in `titleMedium`/`textSecondary` (hidden on mobile).

### Center/Right: Nav Links (Desktop/Tablet)
- Nav items: `About`, `Education`, `Experience`, `Projects`, `Skills`
- Style: `labelMedium`/`JetBrains Mono`/`textSecondary`
- Active state: color → `cyan`, add a `2px` underline in `cyan`
- Hover state: color → `textPrimary`, animated with `AnimatedDefaultTextStyle` (200ms)
- Gap between items: `24px` (desktop), `16px` (tablet)

### Right: CTA Button (Desktop/Tablet)
- Text: `Hire Me` or `Download CV`
- Style: Outlined button — `1px cyan border`, `transparent` bg, `cyan` text
- Hover: background fills with `cyan` at `10%` opacity
- Border radius: `8px`
- Padding: `12px 20px`

### Mobile Nav
- Left: initials badge
- Right: `IconButton` with `Icons.menu_rounded`, color `textSecondary`
- Opens an `EndDrawer`:
  - Background: `#0F1724`
  - Full list of nav items in vertical column, `titleLarge` style
  - Active item: `cyan` with left `3px cyan` border indicator
  - Bottom of drawer: social icon row (same as hero contact icons)

---

## 8. Hero Section

### Purpose
Immediate impression: name, role, face, and ways to connect — all above the fold on every breakpoint.

---

### Desktop Layout (≥ 1200px)

```
┌──────────────────────────────────────────────────────────────────────┐
│  [Navbar]                                                             │
│                                                                       │
│  padding: 120px top, 80px bottom                                      │
│                                                                       │
│  ┌─────────────────────────────────┐   ┌──────────────────────────┐  │
│  │                                 │   │                          │  │
│  │  // flutter_developer           │   │   ┌──────────────────┐   │  │
│  │                                 │   │   │  [Profile Image] │   │  │
│  │  Your Name                      │   │   │   240×240px      │   │  │
│  │  (displayLarge, gradient text   │   │   │   circle         │   │  │
│  │   cyan→purple)                  │   │   └──────────────────┘   │  │
│  │                                 │   │   (rotating glow ring)   │  │
│  │  Flutter Developer &            │   │                          │  │
│  │  Mobile Engineer                │   │                          │  │
│  │  (headlineSmall, textSecondary) │   │                          │  │
│  │                                 │   └──────────────────────────┘  │
│  │  Crafting performant mobile     │                                  │
│  │  experiences with Flutter.      │                                  │
│  │  (bodyLarge, textSecondary)     │                                  │
│  │                                 │                                  │
│  │  ─────────────────────          │                                  │
│  │                                 │                                  │
│  │  [WA] [☎] [✉] [in] [GH]       │                                  │
│  │  (icon buttons, 36px, cyan)     │                                  │
│  │                                 │                                  │
│  │  [Download CV]  [View Projects] │                                  │
│  │                                 │                                  │
│  └─────────────────────────────────┘                                  │
│                                                                       │
└──────────────────────────────────────────────────────────────────────┘
```

**Column split:** Left column `flex: 5`, Right column `flex: 4`, `MainAxisAlignment.center`, gap `80px`.

---

### Tablet Layout (600–1199px)

```
┌────────────────────────────────────────────┐
│  [Navbar]                                   │
│                                             │
│  padding: 80px top, 60px bottom             │
│                                             │
│  ┌─────────────────┐  ┌──────────────────┐  │
│  │  // flutter...  │  │  [Profile Image] │  │
│  │  Name (display  │  │  180×180px       │  │
│  │  Medium)        │  │  glow ring       │  │
│  │  Title (title   │  └──────────────────┘  │
│  │  Large)         │                        │
│  │  tagline        │                        │
│  │  [icons]        │                        │
│  │  [buttons]      │                        │
│  └─────────────────┘                        │
│                                             │
└────────────────────────────────────────────┘
```

**Column split:** Left `flex: 6`, Right `flex: 4`, gap `48px`.

---

### Mobile Layout (< 600px)

```
┌──────────────────────────┐
│  [Navbar]                 │
│                           │
│  padding: 60px top/bottom │
│                           │
│  [Profile Image 140×140]  │  ← centered
│  (glow ring, smaller)     │
│                           │
│  // flutter_developer     │  ← centered, labelSmall
│  Your Name                │  ← centered, displaySmall
│  Flutter Developer        │  ← centered, titleMedium
│  & Mobile Engineer        │
│                           │
│  Crafting performant...   │  ← centered, bodyMedium
│                           │
│  [WA] [☎] [✉] [in] [GH] │  ← centered row
│                           │
│  [Download CV]            │  ← full-width button
│  [View Projects]          │  ← full-width outlined button
│                           │
└──────────────────────────┘
```

---

### Hero Sub-Components

#### Signature Ring (CustomPainter)
```
Outer container: 260px (web), 200px (tablet), 160px (mobile)
Inner profile circle: outer - 12px padding on all sides
Ring: 4px stroke width
Gradient: SweepGradient — stops at [cyan, purple, cyan]
Animation: RotationTransition, duration: 4000ms, repeat infinite
Profile image: CircleAvatar or ClipOval with NetworkImage/AssetImage
```

#### Hero Name — Gradient Text
```dart
ShaderMask(
  shaderCallback: (bounds) => LinearGradient(
    colors: [Color(0xFF00D4F5), Color(0xFF6C63FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).createShader(bounds),
  child: Text(name, style: theme.textTheme.displayLarge!
      .copyWith(color: Colors.white)),
)
```

#### Contact Icon Row
- Icons: WhatsApp (`fab_whatsapp` from font_awesome_flutter), Phone, Email, LinkedIn, GitHub
- Each: `IconButton` 36×36px, icon size 18px, color `textSecondary`
- Hover → color animates to `cyan` (200ms `AnimatedContainer`)
- Tooltip on hover (desktop) showing label (e.g., "Connect on LinkedIn")
- Spacing between icons: `8px`
- On tap: `url_launcher` opens the respective URL/app

#### CTA Buttons
- **Primary** `Download CV`: `ElevatedButton`, background `cyan`, text `primaryBg`, weight 600, border radius `8px`, padding `14px 28px`
- **Secondary** `View Projects`: `OutlinedButton`, border `1px cyan`, text `cyan`, same radius/padding
- On mobile: both are full width, stacked vertically with `12px` gap

---

## 9. About Section

### Purpose
2–4 sentences describing who you are, what drives you, and what you bring to a team.

### Layout

```
DESKTOP / TABLET
┌────────────────────────────────────────────────────────┐
│  // about_me                                            │
│  About Me                                              │
│  ──── (animated cyan underline)                        │
│                                                        │
│  ┌─────────────────────────────────────┐  ┌─────────┐ │
│  │  [About text paragraph — max 680px  │  │  Stat   │ │
│  │   width, bodyLarge, lineHeight 1.7] │  │  Cards  │ │
│  │                                     │  │  (col)  │ │
│  └─────────────────────────────────────┘  └─────────┘ │
└────────────────────────────────────────────────────────┘

MOBILE
┌──────────────────────────┐
│  // about_me             │
│  About Me                │
│  ────                    │
│                          │
│  [About text, full width]│
│                          │
│  [Stat Card] [Stat Card] │  ← 2-column grid
│  [Stat Card] [Stat Card] │
└──────────────────────────┘
```

### Stat Cards (3–4 items)
Examples: `5+ Years Experience`, `15+ Apps Published`, `2 Platforms`

Each card:
```
┌──────────────────┐
│  00              │  ← number, displaySmall, cyan
│  Label           │  ← bodySmall, textSecondary
└──────────────────┘
```
- Background: `card` (`#1A2336`)
- Border: `1px solid #4A5568`
- Border radius: `12px`
- Padding: `20px`
- On desktop: horizontal row; on mobile: 2×2 grid

### Section Background
About section background: `surface` (`#0F1724`) to visually separate from hero.

---

## 10. Education Section

### Layout (all breakpoints)

Vertical timeline — single column, centered on desktop (max-width `720px`), full-width on mobile.

```
// education
Education
────

    ┌──────────────────────────────────────────────┐
●───│  University / Institution Name               │
│   │  Degree — Field of Study      [2020 – 2024] │
│   │  GPA or relevant note (optional)             │
│   └──────────────────────────────────────────────┘
│
│   ┌──────────────────────────────────────────────┐
●───│  Institution Name                            │
    │  Degree — Field               [2018 – 2020] │
    └──────────────────────────────────────────────┘
```

### Timeline Component

| Property             | Value                                              |
|----------------------|----------------------------------------------------|
| Track line           | `2px` vertical, color `card` (`#1A2336`)           |
| Node dot             | `12px` circle, border `2px solid cyan`, bg `primaryBg` |
| Node on active/hover | Filled `cyan`                                       |
| Card background      | `card` (`#1A2336`)                                 |
| Card border          | `1px solid #4A5568`, border radius `12px`          |
| Card padding         | `20px 24px`                                        |
| Institution          | `titleLarge`, `textPrimary`                        |
| Degree               | `titleMedium`, `textSecondary`                     |
| Date range           | `labelSmall`, `cyan`, `JetBrains Mono`, right aligned |
| Gap between items    | `24px`                                             |

Section background: `primaryBg`.

---

## 11. Experience Section

### Layout

Same vertical timeline as Education — single column, max-width `760px`, centered on desktop.

```
// experience
Experience
────

    ┌───────────────────────────────────────────────────┐
●───│  Company Name              [Jan 2022 – Present]   │
│   │  Job Title · Location                             │
│   │                                                   │
│   │  • Accomplishment or responsibility               │
│   │  • Another key achievement                       │
│   │  • Key tech used: Flutter, Dart, BLoC            │
│   └───────────────────────────────────────────────────┘
│
│   ┌───────────────────────────────────────────────────┐
●───│  Previous Company          [Jun 2020 – Dec 2021]  │
    │  Junior Developer                                 │
    │                                                   │
    │  • ...                                            │
    └───────────────────────────────────────────────────┘
```

### Card Content Specs

| Element        | Style                                                         |
|----------------|---------------------------------------------------------------|
| Company        | `titleLarge`, `textPrimary`                                   |
| Date range     | `labelSmall`, `cyan`, `JetBrains Mono`, right-aligned         |
| Job title      | `titleMedium`, `textSecondary`                                |
| Location       | `bodySmall`, `textMuted` (append with ` · ` separator)        |
| Bullet points  | `bodyMedium`, `textSecondary`, `8px` top spacing per bullet   |
| Bullet dot     | `4px` filled circle, color `purple`                           |
| Tech tags      | Small inline chips: `card` bg, `1px cyan` border, `labelSmall` text |

Section background: `surface` (`#0F1724`).

---

## 12. Projects Section

### Purpose
Showcase apps with links to stores or internal demos. Each project is a card.

### Grid Layout

```
DESKTOP (≥ 1200px)   → 3 columns
TABLET  (600–1199px) → 2 columns
MOBILE  (< 600px)    → 1 column (full-width cards)
```

```
// projects
Projects
────

┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  [App Icon]  │  │  [App Icon]  │  │  [App Icon]  │
│  App Name    │  │  App Name    │  │  App Name    │
│  One-line    │  │  One-line    │  │  One-line    │
│  description │  │  description │  │  description │
│              │  │              │  │              │
│  [▶ Play]    │  │  [▶ Play]    │  │  [▶ Play]    │
│  [ Apple]    │  │  [Internal]  │  │  [ Apple]    │
└──────────────┘  └──────────────┘  └──────────────┘
```

### Project Card Specs

| Property            | Value                                                          |
|---------------------|----------------------------------------------------------------|
| Background          | `card` (`#1A2336`)                                             |
| Border              | `1px solid #4A5568`                                            |
| Border on hover     | `1px solid cyan` — animated with `AnimatedContainer` 200ms     |
| Border radius       | `16px`                                                         |
| Padding             | `20px`                                                         |
| App icon            | `56×56px`, border radius `14px`, `ClipRRect`, bg `surface`     |
| App icon placeholder| Gradient square (cyan→purple diagonal) with first letter       |
| App name            | `titleLarge`, `textPrimary`, `8px` top margin from icon        |
| Description         | `bodyMedium`, `textSecondary`, max 2 lines, overflow ellipsis  |
| Divider             | `1px horizontal`, color `#4A5568`, margin `16px 0`             |
| Store badge row     | `Wrap` with `8px` gap                                          |

### Store Badge Component

```
┌─────────────────────────┐
│  ▶  Google Play         │
└─────────────────────────┘
```

| Property        | Value                                                       |
|-----------------|-------------------------------------------------------------|
| Background      | `#0F1724`                                                   |
| Border          | `1px solid #4A5568`                                         |
| Border radius   | `8px`                                                       |
| Padding         | `8px 14px`                                                  |
| Icon            | `16px`, color `textSecondary`                               |
| Label           | `labelMedium`, `JetBrains Mono`, `textSecondary`            |
| Hover           | Border → `cyan`, icon + text → `cyan`                       |
| On tap          | `url_launcher` → store URL                                  |
| "Internal Use"  | Replace store icon with `Icons.lock_outline`, label `Internal` |

Section background: `primaryBg`.

---

## 13. Skills Section

### Layout

Categories are displayed as labeled groups. Each group contains skill chips.

```
DESKTOP: 2 columns of category groups
TABLET:  2 columns
MOBILE:  1 column (full-width stacked)
```

```
// skills
Skills
────

┌──────────────────────────────────┐  ┌──────────────────────────────────┐
│  Mobile Development              │  │  State Management                 │
│  ─── (purple 30px line)         │  │  ─── (purple 30px line)          │
│  [Flutter] [Dart] [iOS] [Android]│  │  [BLoC] [Riverpod] [Provider]    │
│  [FlutterFlow]                   │  │  [GetX]                          │
└──────────────────────────────────┘  └──────────────────────────────────┘

┌──────────────────────────────────┐  ┌──────────────────────────────────┐
│  Backend & APIs                  │  │  Tools & DevOps                   │
│  ───                             │  │  ───                              │
│  [REST] [Firebase] [GraphQL]     │  │  [Git] [GitHub] [Fastlane]        │
│  [Supabase]                      │  │  [CI/CD] [Xcode] [Android Studio] │
└──────────────────────────────────┘  └──────────────────────────────────┘
```

### Category Group Card

| Property            | Value                                                |
|---------------------|------------------------------------------------------|
| Background          | `card` (`#1A2336`)                                   |
| Border              | `1px solid #4A5568`                                  |
| Border radius       | `16px`                                               |
| Padding             | `20px 24px`                                          |
| Category title      | `titleMedium`, `textPrimary`, `Space Grotesk`        |
| Category underline  | `30px × 2px`, color `purple` — animates from 0 width on scroll |
| Chip container      | `Wrap`, `runSpacing: 8px`, `spacing: 8px`, `12px` top margin |

### Skill Chip Component

| Property     | Value                                                       |
|--------------|-------------------------------------------------------------|
| Background   | `primaryBg` (`#080C14`)                                    |
| Border       | `1px solid cyan` at `50%` opacity                           |
| Border radius| `999px` (pill)                                              |
| Padding      | `6px 14px`                                                  |
| Text         | `labelLarge`, `JetBrains Mono`, `textPrimary`               |
| Hover        | Background → `cyan` at `10%`, border → `cyan` at `100%`     |
| Icon (optional) | `14px` icon left of text, color `cyan`, `4px` gap        |

Section background: `surface` (`#0F1724`).

---

## 14. Footer

### Layout (all breakpoints)

```
┌──────────────────────────────────────────────────────────┐
│                                                          │
│  [Name]                                                  │
│  Flutter Developer                                       │
│                                                          │
│  ─────────────────────────────── (1px surface divider)  │
│                                                          │
│  © 2025 [Name]. All rights reserved.    [WA][✉][in][GH] │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

| Property           | Value                                                     |
|--------------------|-----------------------------------------------------------|
| Background         | `#080C14`                                                |
| Top border         | `1px solid #1A2336`                                       |
| Padding            | `48px 0`                                                  |
| Name               | `titleLarge`, `textPrimary`                               |
| Subtitle           | `bodySmall`, `textMuted`                                  |
| Divider            | `1px`, `#1A2336`, `24px` margin vertical                  |
| Copyright text     | `bodySmall`, `textMuted`                                  |
| Social icons       | `24px`, `textMuted`, hover → `cyan`, `8px` gap each       |

---

## 15. Shared Component Library

### Section Container Widget

Every section wraps its content in a `SectionContainer` widget:

```dart
// Props:
//   backgroundColor: Color
//   child: Widget

// Internal structure:
Container(
  color: backgroundColor,
  width: double.infinity,
  padding: EdgeInsets.symmetric(
    vertical: isDesktop ? 80 : isMobile ? 48 : 60,
    horizontal: isDesktop ? 0 : isMobile ? 16 : 32,
  ),
  child: Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: child,
    ),
  ),
)
```

### Section Header Widget

```dart
// Props:
//   eyebrow: String  (e.g., "about_me")
//   title: String    (e.g., "About Me")

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('// $eyebrow', style: labelSmall/cyan/JetBrainsMono),
    SizedBox(height: 8),
    Text(title, style: headlineMedium/textPrimary),
    SizedBox(height: 12),
    AnimatedUnderline(width: 40, color: cyan, height: 2), // scroll-triggered
    SizedBox(height: 40),
  ],
)
```

### Animated Reveal Widget

Wrap every major component (cards, timeline items, stat cards) in this:

```dart
// Scroll-triggered fade + slide-up animation
// Props:
//   delay: Duration (stagger children in lists)
//   child: Widget

AnimatedOpacity(opacity: isVisible ? 1.0 : 0.0, duration: 500ms)
+ Transform.translate(offset: isVisible ? Offset.zero : Offset(0, 24))
// Trigger when widget enters viewport using VisibilityDetector package
```

### Hover Card Wrapper

For project and skill group cards:
```dart
// On desktop: show border color change + very subtle y-axis translate (-2px) on hover
// Use MouseRegion + AnimatedContainer
MouseRegion(
  onEnter: (_) => setState(() => _hovered = true),
  onExit:  (_) => setState(() => _hovered = false),
  child: AnimatedContainer(
    duration: Duration(milliseconds: 200),
    decoration: BoxDecoration(
      color: AppColors.card,
      border: Border.all(
        color: _hovered ? AppColors.cyan : AppColors.textMuted,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    transform: _hovered
        ? Matrix4.translationValues(0, -2, 0)
        : Matrix4.identity(),
    child: child,
  ),
)
```

---

## 16. Animation Guidelines

### Hierarchy of Animations (do not break this priority order)

| Priority | Animation                          | Where                  | Duration | Curve                  |
|----------|------------------------------------|------------------------|----------|------------------------|
| 1        | Signature ring rotation            | Hero avatar            | 4000ms   | `Curves.linear` (loop) |
| 2        | Hero content fade + slide up       | Hero section on load   | 600ms    | `Curves.easeOut`       |
| 3        | Scroll-triggered reveal (per card) | All section cards      | 500ms    | `Curves.easeOut`       |
| 4        | Section header underline expand    | Section headers        | 400ms    | `Curves.easeInOut`     |
| 5        | Navbar transition on scroll        | Navbar                 | 200ms    | `Curves.easeIn`        |
| 6        | Hover micro-interactions           | Cards, buttons, icons  | 200ms    | `Curves.easeInOut`     |

### Rules
- **Never run more than 2 animations simultaneously** (ring + one reveal max at a time).
- **Stagger list items:** Add `delay = index * 80ms` to each card's reveal animation in grids and timelines.
- **Respect `MediaQuery.disableAnimations`:** Wrap all non-essential animations in a check and skip them if true.
- **No looping animations except the signature ring.** One loop, one place.
- **Page-load sequence:**
  1. Navbar fades in → `0ms` delay
  2. Hero eyebrow fades in → `100ms` delay
  3. Hero name fades in + slides up → `200ms`
  4. Hero subtitle → `350ms`
  5. Contact icons row → `500ms`
  6. CTA buttons → `600ms`
  7. Profile image + ring → `300ms` (slightly earlier to feel parallel, not sequential)

---

## 17. Flutter Implementation Notes

### Package Recommendations

| Package                   | Version  | Purpose                                                   |
|---------------------------|----------|-----------------------------------------------------------|
| `google_fonts`            | latest   | `SpaceGrotesk`, `JetBrainsMono`                          |
| `font_awesome_flutter`    | latest   | WhatsApp, LinkedIn, GitHub brand icons                    |
| `url_launcher`            | latest   | Open store links, social profiles, email, phone           |
| `visibility_detector`     | latest   | Trigger scroll animations when widget enters viewport     |
| `animate_do` or `flutter_animate` | latest | Pre-built fade/slide animations with delay support  |
| `scrollable_positioned_list` | latest | Smooth programmatic scroll to section                  |
| `cached_network_image`    | latest   | Profile photo and app icons from URL                      |

### File Structure Recommendation

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       ← All Color constants
│   │   ├── app_text_styles.dart  ← Named text style helpers
│   │   ├── app_spacing.dart      ← Spacing constants
│   │   └── breakpoints.dart      ← Breakpoint values
│   └── theme/
│       └── app_theme.dart        ← ThemeData factory (existing code)
│
├── data/
│   └── portfolio_data.dart       ← All content: name, links, projects, skills, etc.
│
├── features/
│   ├── hero/
│   │   ├── widgets/
│   │   │   ├── hero_section.dart
│   │   │   ├── profile_ring_painter.dart  ← CustomPainter for signature ring
│   │   │   ├── contact_icons_row.dart
│   │   │   └── hero_cta_buttons.dart
│   ├── about/
│   │   └── widgets/about_section.dart
│   ├── education/
│   │   └── widgets/education_section.dart
│   ├── experience/
│   │   └── widgets/experience_section.dart
│   ├── projects/
│   │   └── widgets/
│   │       ├── projects_section.dart
│   │       └── project_card.dart
│   └── skills/
│       └── widgets/
│           ├── skills_section.dart
│           ├── skill_category_card.dart
│           └── skill_chip.dart
│
├── shared/
│   ├── widgets/
│   │   ├── section_container.dart
│   │   ├── section_header.dart
│   │   ├── animated_reveal.dart
│   │   ├── hover_card.dart
│   │   ├── store_badge.dart
│   │   └── timeline_item.dart
│   └── nav/
│       ├── portfolio_nav_bar.dart
│       └── nav_drawer.dart
│
└── main.dart
    └── portfolio_page.dart       ← Assembles all sections in scroll view
```

### Data Model Suggestion

```dart
// portfolio_data.dart

class PortfolioData {
  static const String name       = "Your Name";
  static const String title      = "Flutter Developer & Mobile Engineer";
  static const String tagline    = "Crafting performant mobile experiences with Flutter.";
  static const String photoUrl   = "assets/images/profile.jpg";
  static const String cvUrl      = "https://...";
  static const String whatsapp   = "https://wa.me/...";
  static const String phone      = "tel:+1...";
  static const String email      = "mailto:...";
  static const String linkedin   = "https://linkedin.com/in/...";
  static const String github     = "https://github.com/...";
  static const String about      = "I am...";

  static const List<StatItem> stats = [...];
  static const List<Education> education = [...];
  static const List<Experience> experiences = [...];
  static const List<Project> projects = [...];
  static const List<SkillCategory> skillCategories = [...];
}

class Project {
  final String name;
  final String description;
  final String? iconAsset;
  final String? iconUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final bool isInternal;
  const Project({...});
}

class SkillCategory {
  final String category;
  final List<String> skills;
  const SkillCategory({...});
}
```

### Web-Specific Considerations

- Set `usePathUrlStrategy()` in `main.dart` for clean URLs.
- Add `<meta name="viewport" content="width=device-width, initial-scale=1.0">` to `web/index.html`.
- Add `<meta name="description">` and Open Graph tags for SEO/sharing.
- Add `flutter_web_plugins` cursor behavior: show pointer cursor on all tappable elements using `SystemMouseCursors.click` in `MouseRegion`.
- Disable the default Flutter web loading spinner in `index.html` and replace with a custom minimal loader (3 cyan dots pulsing).
- For performance: use `RepaintBoundary` around the signature ring animation widget to isolate it from the rest of the paint tree.

### Scroll Controller Architecture

```dart
// In portfolio_page.dart:
// Maintain a Map<String, GlobalKey> for each section
final _sectionKeys = {
  'hero':       GlobalKey(),
  'about':      GlobalKey(),
  'education':  GlobalKey(),
  'experience': GlobalKey(),
  'projects':   GlobalKey(),
  'skills':     GlobalKey(),
};

// Scroll-to function:
void scrollToSection(String key) {
  final context = _sectionKeys[key]?.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }
}
```

### Active Nav Detection

```dart
// Track which section is in viewport using ScrollController listener:
// Compare scroll offset against each section's RenderBox.localToGlobal(Offset.zero).dy
// Update a ValueNotifier<String> activeSection
// Nav items subscribe to this notifier and highlight accordingly
```

---

## Quick Reference: Section Background Alternation

| Section    | Background  | Hex       |
|------------|-------------|-----------|
| Navbar     | `surface`   | `#0F1724` |
| Hero       | `primaryBg` | `#080C14` |
| About      | `surface`   | `#0F1724` |
| Education  | `primaryBg` | `#080C14` |
| Experience | `surface`   | `#0F1724` |
| Projects   | `primaryBg` | `#080C14` |
| Skills     | `surface`   | `#0F1724` |
| Footer     | `primaryBg` | `#080C14` |

Alternating between `#080C14` and `#0F1724` creates natural section separation without borders or dividers between sections — the sections breathe into each other.

---

*End of Design Specification — Version 1.0*
