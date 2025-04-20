#define GPIOB_BASE_ADDRESSES  0x40020400

#define GPIOB_MODER   (*(unsigned long *)(GPIOB_BASE_ADDRESSES + 0x00))
#define GPIOB_OTYPER  (*(unsigned long *)(GPIOB_BASE_ADDRESSES + 0x04))
#define GPIOB_ODR     (*(unsigned long *)(GPIOB_BASE_ADDRESSES + 0x14))
#define RCC_AHB1ENR   (*(unsigned long *)(0x40023800 + 0x30))

#define BIN 3

int main() {
    unsigned char pin_mode = 0x1;
    unsigned char pin_output_type = 0x00;

    RCC_AHB1ENR |= (0x1 << 1); // Enable GPIOB

    GPIOB_MODER &= ~(0x03 << (BIN * 2)); // Clear mode bits
    GPIOB_MODER |= (pin_mode << (BIN * 2)); // Set pin mode

    GPIOB_OTYPER &= ~(0x01 << BIN); // Clear output type
    GPIOB_OTYPER |= (pin_output_type << BIN); // Set output type

    GPIOB_ODR |= (0x01 << BIN); // Set pin HIGH

    while (1) {
    }

    return 0;
}
