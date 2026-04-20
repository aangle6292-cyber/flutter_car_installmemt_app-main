import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController rateCtrl = TextEditingController();

  double downPaymentPercent = 10.0;
  int installmentPeriod = 24;
  double monthlyInstallment = 0.00;

  void _calculateInstallment() {
    if (priceCtrl.text.isEmpty || rateCtrl.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('แจ้งเตือน'),
          content: const Text('กรุณาป้อนราคารถและอัตราดอกเบี้ยให้ครบถ้วน'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      return;
    }

    double price = double.parse(priceCtrl.text);
    double rate = double.parse(rateCtrl.text);

    double financeAmount = price - (price * downPaymentPercent / 100);

    double totalInterest =
        (financeAmount * (rate / 100)) * (installmentPeriod / 12);

    double monthly = (financeAmount + totalInterest) / installmentPeriod;

    setState(() {
      monthlyInstallment = monthly;
    });
  }

  void _resetForm() {
    setState(() {
      priceCtrl.clear();
      rateCtrl.clear();
      downPaymentPercent = 10.0;
      installmentPeriod = 24;
      monthlyInstallment = 0.00;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'คำนวณค่างวดรถ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  'images/car.png',
                  height: 120,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('ราคารถ (บาท)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: priceCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('จำนวนเงินดาวน์ (%)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRadioChoice(10),
                    _buildRadioChoice(20),
                    _buildRadioChoice(30),
                    _buildRadioChoice(40),
                    _buildRadioChoice(50),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('ระยะเวลาผ่อน (เดือน)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: installmentPeriod,
                    isExpanded: true,
                    items: [24, 36, 48, 60, 72].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value เดือน'),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        installmentPeriod = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('อัตราดอกเบี้ย (%/ปี)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: rateCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _calculateInstallment,
                      child: const Text('คำนวณ'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _resetForm,
                      child: const Text('ยกเลิก'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ค่างวดรถต่อเดือนเป็นเงิน',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      NumberFormat("#,##0.00").format(monthlyInstallment),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'บาทต่อเดือน',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioChoice(double value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<double>(
          value: value,
          groupValue: downPaymentPercent,
          activeColor: Colors.black87,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onChanged: (newValue) {
            setState(() {
              downPaymentPercent = newValue!;
            });
          },
        ),
        Text('${value.toInt()}'),
        const SizedBox(width: 5),
      ],
    );
  }
}
