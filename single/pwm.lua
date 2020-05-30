LED_Pin = 4
pwm.setup(LED_Pin, 100, 0)
pwm.start(LED_Pin)
pwm.setduty(LED_Pin, 1000)