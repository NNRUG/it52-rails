export class PaidEventSwitcher {
  private static instance: PaidEventSwitcher | null = null;

  private static initPage: string | null = location.href;

  private block: HTMLElement | null;

  private checkbox: HTMLInputElement | null;

  private priceInput: HTMLInputElement | null;

  static init(): void {
    const block = document.getElementById('event_paid_block');
    if (!block) return;

    if (
      !PaidEventSwitcher.instance ||
      PaidEventSwitcher.initPage !== location.href
    ) {
      PaidEventSwitcher.initPage = location.href;
      PaidEventSwitcher.instance = new PaidEventSwitcher();
      document.addEventListener('turbolinks:request-start', () => {
        PaidEventSwitcher.initPage = null;
      });
    }
  }

  private constructor() {
    this.block = document.getElementById('event_paid_block');
    this.checkbox = this.block?.querySelector('input[type="checkbox"]') ?? null;
    this.priceInput = document.getElementById('event_price_input') as HTMLInputElement | null;

    this.syncPriceDisabled();
    this.bindEvents();
  }

  private syncPriceDisabled(): void {
    if (this.priceInput && this.checkbox) {
      this.priceInput.disabled = !this.checkbox.checked;
    }
  }

  private bindEvents(): void {
    if (this.checkbox) {
      this.checkbox.addEventListener('change', () => this.syncPriceDisabled());
    }
  }
}

export class ParticipantsLimitSwitcher {
  private static instance: ParticipantsLimitSwitcher | null = null;

  private static initPage: string | null = location.href;

  private block: HTMLElement | null;

  private checkbox: HTMLInputElement | null;

  private limitInput: HTMLInputElement | null;

  static init(): void {
    const block = document.getElementById('event_participants_limit_block');
    if (!block) return;

    if (
      !ParticipantsLimitSwitcher.instance ||
      ParticipantsLimitSwitcher.initPage !== location.href
    ) {
      ParticipantsLimitSwitcher.initPage = location.href;
      ParticipantsLimitSwitcher.instance = new ParticipantsLimitSwitcher();
      document.addEventListener('turbolinks:request-start', () => {
        ParticipantsLimitSwitcher.initPage = null;
      });
    }
  }

  private constructor() {
    this.block = document.getElementById('event_participants_limit_block');
    this.checkbox = this.block?.querySelector('input[type="checkbox"]') ?? null;
    this.limitInput = document.getElementById('event_participants_limit_input') as HTMLInputElement | null;

    this.syncLimitDisabled();
    this.bindEvents();
  }

  private syncLimitDisabled(): void {
    if (this.limitInput && this.checkbox) {
      this.limitInput.disabled = !this.checkbox.checked;
    }
  }

  private bindEvents(): void {
    if (this.checkbox) {
      this.checkbox.addEventListener('change', () => this.syncLimitDisabled());
    }
  }
}
