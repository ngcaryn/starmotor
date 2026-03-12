/**
 * StarMotor — Metallic Design System
 *
 * Palette inspired by precision-engineered automotive materials:
 * brushed aluminum, gunmetal steel, and platinum finishes.
 */

const Colors = {
  // ─── Backgrounds ──────────────────────────────────────────────────────────
  /** Primary app background — deep charcoal */
  bgPrimary: '#111112',
  /** Card/surface background — gunmetal */
  bgCard: '#1a1a1c',
  /** Recessed inset areas */
  bgInset: '#0e0e0f',
  /** Elevated surface (modals, sheets) */
  bgElevated: '#1f1f21',

  // ─── Borders ──────────────────────────────────────────────────────────────
  /** Default border — dark steel */
  border: '#2c2c2e',
  /** Subtle divider */
  borderDark: '#1c1c1e',
  /** Active / highlighted border */
  borderActive: '#a0aab4',

  // ─── Accent — Brushed Aluminum ────────────────────────────────────────────
  /** Primary accent — cool silver */
  accent: '#a0aab4',
  /** Dimmed accent */
  accentDim: '#6a7480',
  /** Bright/active accent for selected states */
  accentBright: '#c8d2dc',

  // ─── Typography ───────────────────────────────────────────────────────────
  /** Primary text — near-white platinum */
  textPrimary: '#f0f0f2',
  /** Secondary text — silver gray */
  textSecondary: '#8c8c90',
  /** Dimmed / placeholder text */
  textDim: '#4a4a4e',
  /** Accent-colored label text */
  textAccent: '#a0aab4',

  // ─── Semantic ─────────────────────────────────────────────────────────────
  /** Muted danger / error */
  danger: '#b84040',
  /** Muted success */
  success: '#4a7c5e',
  /** Warning */
  warning: '#8a6a30',

  // ─── Overlay ──────────────────────────────────────────────────────────────
  overlay: 'rgba(14, 14, 15, 0.82)',
} as const;

export default Colors;
