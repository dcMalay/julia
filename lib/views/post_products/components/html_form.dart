import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:julia/const/const.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview_flutter;

const htmldata = '''

<h1>Html Form</h1>
<form action="https://the-url-with-post-method/post" method="POST">
  <input type="hidden" name="foo" value="bar" />
  <input type="submit" value="Submit">
</form>
    <div class="col-12">
   
      <p>Color</p>
     
     <input type="radio" name="Color" class="" required="" value=" blue "><span style="margin: 0px 15px 0px 5px"> blue </span>
     <input type="radio" name="Color" class="" required="" value=" green"><span style="margin: 0px 15px 0px 5px"> green</span>
     <input type="radio" name="Color" class="" required="" value="red"><span style="margin: 0px 15px 0px 5px">red</span>
 
          </div>

    
      <div class="col-12 col-md-6">
   
       <lable class="my-2 "><b>Type</b></lable>
        <select name="Type" class="form-control" required="" >
        <option value=" Wireless"> Wireless</option><option value="Wired">Wired</option>
          </select>  
          </div>

    
          <div class="col-12">
   
          <lable class="my-2 " style="display: block;">Fuel</lable>
     
            <input type="checkbox" name="Fuel" class="" required="" value="m"><span style="margin: 0px 15px 0px 5px">m</span><input type="checkbox" name="Fuel" class="" required="" value="l"><span style="margin: 0px 15px 0px 5px">l</span><input type="checkbox" name="Fuel" class="" required="" value="k"><span style="margin: 0px 15px 0px 5px">k</span>
 
          </div>

    
       <div class="col-12">
   
        <lable class="my-2 " style="display: block;"><b>Brand</b></lable>
     
        <input type="radio" name="Brand" class="" required="" value="Micromax"><span style="margin: 0px 15px 0px 5px">Micromax</span>
        <input type="radio" name="Brand" class="" required="" value="Realme"><span style="margin: 0px 15px 0px 5px">Realme</span>
        <input type="radio" name="Brand" class="" required="" value="POCO"><span style="margin: 0px 15px 0px 5px">POCO</span>
        <input type="radio" name="Brand" class="" required="" value="Motorola"><span style="margin: 0px 15px 0px 5px">Motorola</span>
        <input type="radio" name="Brand" class="" required="" value="Apple"><span style="margin: 0px 15px 0px 5px">Apple</span>
 
    </div>

''';

class HtmlForm extends StatefulWidget {
  const HtmlForm({super.key});

  @override
  State<HtmlForm> createState() => _HtmlFormState();
}

class _HtmlFormState extends State<HtmlForm> {
  static const htmldata = '''

<h1>Html Form</h1>
<form action="https://the-url-with-post-method/post" method="POST">
  <input type="hidden" name="foo" value="bar" />
  <input type="submit" value="Submit"/>
</form>
    <div class="col-12">

      <p>Color</p>

     <input type="radio" name="Color" class="" required="" value=" blue "><span style="margin: 0px 15px 0px 5px"> blue </span>
     <input type="radio" name="Color" class="" required="" value=" green"><span style="margin: 0px 15px 0px 5px"> green</span>
     <input type="radio" name="Color" class="" required="" value="red"><span style="margin: 0px 15px 0px 5px">red</span>

          </div>

      <div class="col-12 col-md-6">

       <lable class="my-2 "><b>Type</b></lable>
        <select name="Type" class="form-control" required="" >
        <option value=" Wireless"> Wireless</option><option value="Wired">Wired</option>
          </select>
          </div>

          <div class="col-12">

          <lable class="my-2 " style="display: block;">Fuel</lable>

            <input type="checkbox" name="Fuel" class="" required="" value="m"><span style="margin: 0px 15px 0px 5px">m</span><input type="checkbox" name="Fuel" class="" required="" value="l"><span style="margin: 0px 15px 0px 5px">l</span><input type="checkbox" name="Fuel" class="" required="" value="k"><span style="margin: 0px 15px 0px 5px">k</span>

          </div>

       <div class="col-12">

        <lable class="my-2 " style="display: block;"><b>Brand</b></lable>

        <input type="radio" name="Brand" class="" required="" value="Micromax"><span style="margin: 0px 15px 0px 5px">Micromax</span>
        <input type="radio" name="Brand" class="" required="" value="Realme"><span style="margin: 0px 15px 0px 5px">Realme</span>
        <input type="radio" name="Brand" class="" required="" value="POCO"><span style="margin: 0px 15px 0px 5px">POCO</span>
        <input type="radio" name="Brand" class="" required="" value="Motorola"><span style="margin: 0px 15px 0px 5px">Motorola</span>
        <input type="radio" name="Brand" class="" required="" value="Apple"><span style="margin: 0px 15px 0px 5px">Apple</span>

    </div>

''';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // child: HtmlWidget(
      //   htmldata,
      //   factoryBuilder: (c) => _CustomWidgetFactory(c),
      // ),
      child: Html(
        data: htmldata,
        style: {"h1": Style(color: greenColor)},
      ),
    );
  }
}

// class _CustomWidgetFactory extends WidgetFactory {
//   _CustomWidgetFactory(HtmlWidgetConfig config) : super(config);

//   @override
//   NodeMetadata parseLocalName(NodeMetadata meta, String localName) {
//     if (localName != 'form') return super.parseLocalName(meta, localName);

//     return lazySet(null,
//         buildOp: BuildOp(
//           onWidgets: (meta, _) => [
//             Builder(
//               builder: (context) => TextButton(
//                 child: Text("Submit this form."),
//                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//                     builder: (_) => _FormSubmit(meta.domElement.outerHtml))),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(title: Text('issue 126')),
//           body: HtmlWidget(
//             htmldata,
//             factoryBuilder: (c) => _CustomWidgetFactory(c),
//           ),
//         ),
//       );
// }

// class _CustomWidgetFactory extends WidgetFactory {
//   _CustomWidgetFactory(HtmlWidgetConfig config) : super(config);

//   @override
//   NodeMetadata parseLocalName(NodeMetadata meta, String localName) {
//     if (localName != 'form') return super.parseLocalName(meta, localName);

//     return lazySet(null,
//         buildOp: BuildOp(
//           onWidgets: (meta, _) => [
//             Builder(
//               builder: (context) => TextButton(
//                 child: Text("Submit this form."),
//                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//                     builder: (_) => _FormSubmit(meta.domElement.outerHtml))),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class _FormSubmit extends StatelessWidget {
//   final String html;

//   _FormSubmit(String formHtml)
//       : html = """<html>
// <body onload="document.getElementsByTagName('form')[0].submit();">
//   <p>Loading...</p>
//   <div style="opacity: 0">$formHtml</div>
// </body>
// </html>""";

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(),
//         body: webview_flutter.WebView(
//           initialUrl: Uri.dataFromString(
//             html,
//             mimeType: 'text/html',
//           ).toString(),
//           javascriptMode: webview_flutter.JavascriptMode.unrestricted,
//         ),
//       );
// }
