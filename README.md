# 8_bits_adder
8_bits_adder
---

# 8-Bit Adder (8비트 에더)

## 📁 프로젝트 개요
이 프로젝트는 Verilog를 사용하여 구조적으로 설계된 8비트 에더(Adder)입니다. 설계는 FPGA 보드에서 10진수 출력이 가능하도록 구현되었습니다.

---

## 🛠️ 설계 구조
8비트 에더는 계층적 설계 방식을 사용하여 아래와 같은 단계로 구성되었습니다:

1. **Half Adder (반가산기)**
2. **Full Adder (전가산기)**
3. **4-Bit Full Adder (4비트 전가산기)**
4. **8-Bit Full Adder (8비트 전가산기)**

이러한 단계적 설계를 통해 모듈화된 코드를 작성하고, 재사용성과 유지보수성을 높였습니다.

---

## 🎯 기능
- **이진수 입력**: 8비트의 두 이진수를 입력으로 받습니다.
- **10진수 출력**: FPGA 보드에서 결과값을 10진수 형태로 출력하도록 설계되었습니다.
- **FPGA 호환성**: 실제 하드웨어에서 테스트 가능하도록 구현되었습니다.

---

## 🔗 사용법
1. Verilog 파일을 다운로드합니다. , (xdc 파일은 constraint파일입니다.)
2. FPGA 개발 환경 (예: Xilinx Vivado, Quartus II)에서 프로젝트를 생성하고 파일을 추가합니다.
3. 입력을 설정하고 FPGA 보드에 업로드합니다.
4. 10진수로 출력되는 결과를 확인합니다.

---


## 💡 추가 정보
- FPGA 보드에 따라 핀 매핑과 출력 방식이 달라질 수 있습니다.
- 필요시 `testbench` 파일을 추가하여 시뮬레이션을 통한 검증을 권장합니다.
