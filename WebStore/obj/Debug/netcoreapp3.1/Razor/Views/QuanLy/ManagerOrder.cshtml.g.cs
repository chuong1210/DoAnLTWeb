#pragma checksum "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml" "{8829d00f-11b8-4213-878b-770e8597ac16}" "2d7834167d7fc035024e973e1bdaf151daba9d70a936eb9564c4637bf3ca2dfd"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_QuanLy_ManagerOrder), @"mvc.1.0.view", @"/Views/QuanLy/ManagerOrder.cshtml")]
namespace AspNetCore
{
    #line default
    using global::System;
    using global::System.Collections.Generic;
    using global::System.Linq;
    using global::System.Threading.Tasks;
    using global::Microsoft.AspNetCore.Mvc;
    using global::Microsoft.AspNetCore.Mvc.Rendering;
    using global::Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\_ViewImports.cshtml"
using WebStore

#nullable disable
    ;
#nullable restore
#line 2 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\_ViewImports.cshtml"
using WebStore.Models

#line default
#line hidden
#nullable disable
    ;
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"Sha256", @"2d7834167d7fc035024e973e1bdaf151daba9d70a936eb9564c4637bf3ca2dfd", @"/Views/QuanLy/ManagerOrder.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"Sha256", @"0ca74d9d3d8f0fda11e57151523a5ee9557a88a1c5aba4211246523de85a92d1", @"/Views/_ViewImports.cshtml")]
    #nullable restore
    public class Views_QuanLy_ManagerOrder : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<WebStore.Models.HoaDonDTO>>
    #nullable disable
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
  
    ViewData["Title"] = "ManagerOrder";
    Layout = "~/Views/Shared/_ManagerLayout.cshtml";

#line default
#line hidden
#nullable disable

            WriteLiteral(@"
<h1>ManagerOrder</h1>

<table class=""table"">
    <thead>
        <tr>
            <th>
                Mã đơn hàng 
            </th>

            <th>
                Email khách hàng
            </th>
            <th>
                Tổng tiền 
            </th>
            <th>
                Phương thức thanh toán
            </th>
            <th>
                Trạng thái thanh toán
            </th>
            <th>Cập nhật trạng thái</th>
            <th>Thao tác</th>
        </tr>
    </thead>
    <tbody>
");
#nullable restore
#line 34 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
 foreach (var item in Model) {

#line default
#line hidden
#nullable disable

            WriteLiteral("        <tr>\r\n            <td>\r\n                <a");
            BeginWriteAttribute("href", " href=\"", 783, "\"", 848, 1);
            WriteAttributeValue("", 790, 
#nullable restore
#line 37 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                          Url.Action("DetailOrder", "QuanLy", new { id = item.Id })

#line default
#line hidden
#nullable disable
            , 790, 58, false);
            EndWriteAttribute();
            WriteLiteral(">\r\n                    ");
            Write(
#nullable restore
#line 38 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                     Html.DisplayFor(modelItem => item.Id)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </a>\r\n            </td>\r\n       \r\n            <td>\r\n                ");
            Write(
#nullable restore
#line 43 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                 Html.DisplayFor(modelItem => item.Email)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </td>\r\n            <td>\r\n                ");
            Write(
#nullable restore
#line 46 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                 Html.DisplayFor(modelItem => item.TongTien)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </td>\r\n");
#nullable restore
#line 48 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                  
                    string paymentMethodDisplay = "";
                    switch (item.PhuongThucTT)
                    {
                        case "TheTinDung":
                            paymentMethodDisplay = "Thẻ tín dụng";
                            break;
                        case "ChuyenKhoan":
                            paymentMethodDisplay = "Chuyển khoản";
                            break;
                        case "TienMat":
                            paymentMethodDisplay = "Tiền mặt";
                            break;
                        case "TheMomo":
                            paymentMethodDisplay = "Thẻ Momo";
                            break;
                        default:
                            paymentMethodDisplay = "Không xác định";
                            break;
                    }
                

#line default
#line hidden
#nullable disable

            WriteLiteral("                <td>\r\n                    ");
            Write(
#nullable restore
#line 70 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                     paymentMethodDisplay

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
            Write(
#nullable restore
#line 73 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                     item.TrangThaiTT

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n\r\n\r\n            <th>\r\n                ");
            Write(
#nullable restore
#line 78 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                 Html.ActionLink("Complete", "InfoOrderComplete", new { id = item.Id })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral(" |\r\n                    ");
            Write(
#nullable restore
#line 79 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                     Html.ActionLink("Incomplete", "InfoOrderIncomplete", new { id = item.Id })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                    ");
            Write(
#nullable restore
#line 82 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                     Html.ActionLink("Edit", "EditOrder", new { id = item.Id })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral(" |\r\n                    ");
            Write(
#nullable restore
#line 83 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
                     Html.ActionLink("Delete", "DeleteOrder", new { id = item.Id })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </th>\r\n        </tr>\r\n");
#nullable restore
#line 86 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerOrder.cshtml"
}

#line default
#line hidden
#nullable disable

            WriteLiteral("    </tbody>\r\n</table>\r\n");
        }
        #pragma warning restore 1998
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<WebStore.Models.HoaDonDTO>> Html { get; private set; } = default!;
        #nullable disable
    }
}
#pragma warning restore 1591
