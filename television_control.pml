// تعریف نوع مقادیر ممکن برای حالت‌های مختلف تلویزیون
mtype = {Off, On, Menu, VolumeAdjust, ChannelChange};

// مقدار اولیه حالت تلویزیون
mtype state = Off;

// فرآیند تغییر حالت بین روشن و خاموش کردن تلویزیون
proctype PowerToggle(){
  if
  :: state == Off -> state = On // اگر حالت تلویزیون خاموش باشد، به روشن تغییر کند
  :: state == On -> state = Off // اگر حالت تلویزیون روشن باشد، به خاموش تغییر کند
  fi;
}

// فرآیند تغییر حالت بین حالت روشن و منوی تلویزیون
proctype MenuToggle(){
  if
  :: state == On -> state = Menu // اگر حالت تلویزیون روشن باشد، به منو تغییر کند
  :: state == Menu -> state = On // اگر حالت تلویزیون در منو باشد، به روشن تغییر کند
  fi;
}

// فرآیند تغییر حالت بین حالت روشن و تنظیم حجم صدا
proctype VolumeAdjustToggle(){
  if
  :: state == On -> state = VolumeAdjust // اگر حالت تلویزیون روشن باشد، به تنظیم حجم صدا تغییر کند
  :: state == VolumeAdjust -> state = On // اگر حالت تلویزیون در تنظیم حجم صدا باشد، به روشن تغییر کند
  fi;
}

// فرآیند تغییر حالت بین حالت روشن و تغییر کانال
proctype ChannelChangeToggle(){
  if
  :: state == On -> state = ChannelChange // اگر حالت تلویزیون روشن باشد، به تغییر کانال تغییر کند
  :: state == ChannelChange -> state = On // اگر حالت تلویزیون در تغییر کانال باشد، به روشن تغییر کند
  fi;
}

// فرآیند فعال کنترل از راه دور
active proctype RemoteControl(){
  do
  :: run PowerToggle() // اجرای فرآیند روشن/خاموش کردن تلویزیون
  :: (state==On) -> run MenuToggle() // اگر تلویزیون روشن باشد، اجرای فرآیند منو
  :: (state== On) -> run VolumeAdjustToggle() // اگر تلویزیون روشن باشد، اجرای فرآیند تنظیم حجم صدا
  :: (state==On) -> run ChannelChangeToggle() // اگر تلویزیون روشن باشد، اجرای فرآیند تغییر کانال
  od;
}

// مقدار اولیه برای شروع فرآیند کنترل از راه دور
init{
  run RemoteControl(); // اجرای فرآیند کنترل از راه دور
}
