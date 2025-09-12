#include <stdint.h>
#include "stm32f103xb.h"

void delay( volatile uint32_t count ) {
	while ( count-- ) { __NOP(); };
}

int main( void ) {
  RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
  GPIOA->CRL &= ~(GPIO_CRL_MODE5 | GPIO_CRL_CNF5);
  GPIOA->CRL |= GPIO_CRL_MODE5_1 | GPIO_CRL_MODE5_0;
  volatile unsigned int x = 1;
  while( 1 ) {
    if(x) {
      GPIOA->ODR ^= GPIO_ODR_ODR5;
      delay( 900000 );
    }
    else {
      GPIOA->ODR ^= GPIO_ODR_ODR5;
      delay( 900000 );
    }
    x++;
    if( x == 2 ) x == 0;
  } 
}
