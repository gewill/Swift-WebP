@testable import SwiftWebP
import Testing
import WebP

struct WebPBridgingTests {
    @Test
    func libwebpVersionIsSane() {
        let encoderVersion = WebPEncoder.libwebpVersion
        let decoderVersion = WebPDecoder.libwebpVersion

        #expect(encoderVersion.major >= 1)
        #expect(decoderVersion.major >= 1)
    }

    @Test
    func losslessPresetAndValidation() throws {
        let config = try WebPEncoderConfig.losslessPreset(level: 6)
        #expect(config.lossless == 1)
        #expect(config.validate())
    }

    @Test
    func decBufferExternalMemoryModeSemantics() throws {
        var config = try SwiftWebP.WebPDecoderConfig()
        config.output.externalMemoryMode = .internalMemory
        #expect(config.output.externalMemoryMode == .internalMemory)
        #expect(config.output.rawValue.is_external_memory == 0)

        config.output.externalMemoryMode = .externalMemory
        #expect(config.output.externalMemoryMode == .externalMemory)
        #expect(config.output.rawValue.is_external_memory == 1)

        config.output.externalMemoryMode = .externalMemorySlow
        #expect(config.output.externalMemoryMode == .externalMemorySlow)
        #expect(config.output.rawValue.is_external_memory == 2)
    }

    @Test
    func decBufferExternalMemoryModeMapsValuesGreaterThanTwoToSlow() {
        let rawBuffer = WebP.WebPDecBuffer(
            colorspace: WEBP_CSP_MODE(rawValue: UInt32(ColorspaceMode.RGBA.rawValue)),
            width: 1,
            height: 1,
            is_external_memory: 3,
            u: WebP.WebPDecBuffer.__Unnamed_union_u(
                RGBA: WebP.WebPRGBABuffer(
                    rgba: nil,
                    stride: 4,
                    size: 4
                )
            ),
            pad: (0, 0, 0, 0),
            private_memory: nil
        )
        let buffer = WebPDecBuffer(rawValue: rawBuffer)
        #expect(buffer.externalMemoryMode == .externalMemorySlow)
    }
}
