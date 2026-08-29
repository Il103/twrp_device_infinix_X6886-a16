# minimal.mk - minimal product config so the build only produces recovery.

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.flavor=eng \
    ro.product.cpu.abi=arm64-v8a

PRODUCT_CHARACTERISTICS := nosdcard
PRODUCT_SHIPPING_API_LEVEL := 36
