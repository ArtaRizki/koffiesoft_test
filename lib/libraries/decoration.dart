import 'package:flutter/material.dart';
import 'color.dart';
import 'textstyle.dart';

paketDetailDecoration(String hintTxt, bool isEmpty) {
  return InputDecoration(
      suffixIcon:
          Icon(Icons.warning, color: isEmpty ? Colors.red : Colors.transparent),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter12Gray());
}

paketDecoration(String hintTxt, bool isEmpty) {
  return InputDecoration(
      suffixIcon:
          Icon(Icons.warning, color: isEmpty ? Colors.red : Colors.transparent),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter12Gray());
}

paketDetailHargaJualDisableDecoration(String hintTxt, bool isEmpty) {
  return InputDecoration(
      filled: true,
      fillColor: const Color.fromRGBO(176, 176, 176, 0.5),
      suffixIcon:
          Icon(Icons.warning, color: isEmpty ? Colors.red : Colors.transparent),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter12Gray());
}

paketDecorationDatePicker(String hintTxt, bool isEmpty) {
  return InputDecoration(
      suffixIcon:
          Icon(Icons.warning, color: isEmpty ? Colors.red : Colors.transparent),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter12Gray());
}

// paketDecorationWoIconDropdown(String hintTxt, bool isEmpty) {
//   return InputDecoration(
//       suffixIcon: SvgPicture.asset(
//         "assets/icons/katalog/chevron-down.svg",
//         height: 8,
//         width: 4.8,
//         fit: BoxFit.scaleDown,
//       ),
//       border: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(
//             color:
//                 isEmpty ? Colors.red : Colors.blue),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
//       ),
//       // perlu diatur ulang jika ada form yang disable
//       disabledBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
//       ),
//       focusColor: Colors.blue,
//       contentPadding: const EdgeInsets.all(10),
//       alignLabelWithHint: true,
//       hintText: hintTxt,
//       hintStyle: inter12Gray());
// }

generalDecoration(String hintTxt, String error) {
  return InputDecoration(
    suffixIcon: Icon(Icons.warning,
        color: error != "" ? Colors.red : Colors.transparent),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: error != "" ? Colors.red : Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: error != "" ? Colors.red : Colors.blue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: error != "" ? Colors.red : Colors.grey),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: error != "" ? Colors.red : Colors.grey),
    ),
    focusColor: Colors.blue,
    contentPadding: const EdgeInsets.all(10),
    alignLabelWithHint: true,
    hintText: hintTxt,
  );
}

registerDecoration(String hintTxt, bool isEmpty) {
  return InputDecoration(
      suffixIcon:
          Icon(Icons.warning, color: isEmpty ? Colors.red : Colors.transparent),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter12Gray());
}

viewOnlyDecoration(String hintTxt, bool isEmpty) {
  return InputDecoration(
      enabled: false,
      border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Color(0xff575757))),
      focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Color.fromRGBO(24, 204, 113, 1))),
      enabledBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Color(0xff575757))),
      disabledBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Color(0xff575757))),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter14Gray2());
}

registerDecorationWoIcon(String hintTxt, bool isEmpty) {
  return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.all(10),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter12Gray());
}

// registerDecorationWoIconDropdown(String hintTxt, bool isEmpty,
//     {bool disabled = false}) {
//   return InputDecoration(
//       suffixIcon: SvgPicture.asset(
//         "assets/icons/katalog/chevron-down.svg",
//         height: 8,
//         width: 4.8,
//         fit: BoxFit.scaleDown,
//       ),
//       filled: disabled,
//       fillColor: disabled ? Colors.grey.withOpacity(0.25) : null,
//       border: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(
//             color:
//                 isEmpty ? Colors.red : Colors.blue),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
//       ),
//       // perlu diatur ulang jika ada form yang disable
//       disabledBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: isEmpty ? Colors.red : Colors.grey),
//       ),
//       focusColor: Colors.blue,
//       contentPadding: const EdgeInsets.all(10),
//       alignLabelWithHint: true,
//       hintText: hintTxt,
//       hintStyle: inter12Gray());
// }

// searchDecoration(String hintTxt, {required Function onClear}) {
//   return InputDecoration(
//       prefixIcon: const Padding(
//         padding: EdgeInsets.only(left: 12, right: 5),
//         child: Icon(Icons.search, color: Colors.black54, size: 22),
//       ),
//       suffixIcon: InkWell(
//         onTap: () => onClear(),
//         child: SvgPicture.asset(
//           "assets/icons/katalog/x-circle-small.svg",
//           fit: BoxFit.scaleDown,
//         ),
//       ),
//       border: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: Color.fromRGBO(24, 204, 113, 1)),
//       ),
//       enabledBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(6)),
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//       focusColor: Colors.blue,
//       contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
//       prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 30),
//       alignLabelWithHint: true,
//       hintText: hintTxt,
//       hintStyle: inter14Gray());
// }

searchDecorationGray(String hintTxt, {required Function onClear, clearIcon}) {
  return InputDecoration(
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 12, right: 5),
        child: Icon(Icons.search, color: Colors.black54, size: 22),
      ),
      suffixIcon: clearIcon == true
          ? InkWell(
              onTap: () => onClear(),
              child: SizedBox(
                width: 13,
                height: 13,
                child: Image.asset('assets/images/cleartext.png'),
              ),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: gray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: gray),
      ),
      focusColor: Colors.blue,
      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 30),
      alignLabelWithHint: true,
      hintText: hintTxt,
      hintStyle: inter14Gray());
}
