// تعریف مقادیر مختلف حالت‌های دستگاه
mtype DeviceState = {Off, On, Menu, InputSelect, VolumeAdjust, ChannelChange, AppMode};

// تعریف مقادیر مختلف دکمه‌های کنترل
mtype ControlButton = {Power, MenuBtn, InputBtn, VolUp, VolDown, ChanUp, ChanDown, AppBtn, ExitBtn};

// مقدار اولیه حالت دستگاه
mtype state = Off;

// فرآیند روشن/خاموش کردن دستگاه
proctype PowerOnOff() {
    if
    // اگر حالت دستگاه خاموش است، آن را روشن کن
    :: state == Off -> state = On
    // اگر حالت دستگاه روشن است، آن را خاموش کن
    :: state == On -> state = Off
    fi;
}

// فرآیند باز/بسته کردن منو
proctype OpenCloseMenu() {
    if
    // اگر حالت دستگاه روشن است، منو را باز کن
    :: state == On -> state = Menu
    // اگر حالت دستگاه منو است، به حالت روشن برگرد
    :: state == Menu -> state = On
    fi;
}

// فرآیند انتخاب ورودی
proctype SelectInput() {
    if
    // اگر حالت دستگاه روشن است، حالت انتخاب ورودی را فعال کن
    :: state == On -> state = InputSelect
    // اگر حالت دستگاه انتخاب ورودی است، به حالت روشن برگرد
    :: state == InputSelect -> state = On
    fi;
}

// فرآیند تنظیم صدا
proctype AdjustVolume() {
    if
    // اگر حالت دستگاه روشن است، حالت تنظیم صدا را فعال کن
    :: state == On -> state = VolumeAdjust
    // اگر حالت دستگاه تنظیم صدا است، به حالت روشن برگرد
    :: state == VolumeAdjust -> state = On
    fi;
}

// فرآیند تغییر کانال
proctype ChangeChannel() {
    if
    // اگر حالت دستگاه روشن است، حالت تغییر کانال را فعال کن
    :: state == On -> state = ChannelChange
    // اگر حالت دستگاه تغییر کانال است، به حالت روشن برگرد
    :: state == ChannelChange -> state = On
    fi;
}

// فرآیند باز/بسته کردن اپلیکیشن
proctype OpenCloseApp() {
    if
    // اگر حالت دستگاه روشن است، حالت اپلیکیشن را فعال کن
    :: state == On -> state = AppMode
    // اگر حالت دستگاه اپلیکیشن است، به حالت روشن برگرد
    :: state == AppMode -> state = On
    fi;
}

// فرآیند فعال کردن دستیار صوتی
proctype ActivateVoiceAssistant() {
    if
    // اگر حالت دستگاه روشن است، دستیار صوتی را فعال کن
    :: state == On -> state = VoiceAssistant
    // اگر حالت دستگاه دستیار صوتی است، به حالت روشن برگرد
    :: state == VoiceAssistant -> state = On
    fi;
}

// فرآیند کنترل از راه دور
active proctype RemoteControl() {
    do
    // اجرای فرآیند روشن/خاموش کردن در حالت‌های روشن و خاموش
    :: (state == Off || state == On) -> run PowerOnOff()
    // اجرای فرآیند باز/بسته کردن منو در حالت‌های روشن و منو
    :: (state == On || state == Menu) -> run OpenCloseMenu()
    // اجرای فرآیند انتخاب ورودی در حالت‌های روشن و انتخاب ورودی
    :: (state == On || state == InputSelect) -> run SelectInput()
    // اجرای فرآیند تنظیم صدا در حالت‌های روشن و تنظیم صدا
    :: (state == On || state == VolumeAdjust) -> run AdjustVolume()
    // اجرای فرآیند تغییر کانال در حالت‌های روشن و تغییر کانال
    :: (state == On || state == ChannelChange) -> run ChangeChannel()
    // اجرای فرآیند باز/بسته کردن اپلیکیشن در حالت‌های روشن و اپلیکیشن
    :: (state == On || state == AppMode) -> run OpenCloseApp()
    // اجرای فرآیند فعال کردن دستیار صوتی در حالت‌های روشن و دستیار صوتی
    :: (state == On || state == VoiceAssistant) -> run ActivateVoiceAssistant()
    od;
}

// ویژگی ایمنی: حالت دستگاه نباید نامعتبر باشد
ltl safety { [](state == Off || state == On || state == Menu || state == InputSelect || state == VolumeAdjust || state == ChannelChange || state == AppMode || state == VoiceAssistant) }

// ویژگی liveness: در نهایت، حالت دستگاه باید روشن شود
ltl liveness { <> (state == On) }

// آغاز فرآیند کنترل از راه دور
init {
    run RemoteControl();
}
