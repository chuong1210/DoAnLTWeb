#pragma checksum "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml" "{8829d00f-11b8-4213-878b-770e8597ac16}" "d1293868311bf5e3048cdaf037f53fcf67d2cbe8990a634e585c6a424cd2e12d"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_QuanLy_DetailOrder), @"mvc.1.0.view", @"/Views/QuanLy/DetailOrder.cshtml")]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"Sha256", @"d1293868311bf5e3048cdaf037f53fcf67d2cbe8990a634e585c6a424cd2e12d", @"/Views/QuanLy/DetailOrder.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"Sha256", @"0ca74d9d3d8f0fda11e57151523a5ee9557a88a1c5aba4211246523de85a92d1", @"/Views/_ViewImports.cshtml")]
    #nullable restore
    public class Views_QuanLy_DetailOrder : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<WebStore.Models.OrderDetailViewModel>
    #nullable disable
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
  
    ViewData["Title"] = "DetailOrder";
    Layout = "~/Views/Shared/_ManagerLayout.cshtml";

#line default
#line hidden
#nullable disable

            WriteLiteral(@"
<h1>Detail</h1>

<div>
    <h4>Order Information</h4>
    <hr />
    <div class=""row"">
        <div class=""col-sm-8"">
            <div class=""row"">
                <table class=""table"">
                    <thead>
                        <tr>
                            <th class=""col-md-2"">Image</th>
                            <th class=""col-md-6"">Book Title</th>
                            <th class=""col-md-4"">Quantity</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
");
#nullable restore
#line 26 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                         foreach (var item in Model.OrderItem)
                        {
                           

#line default
#line hidden
#nullable disable

            WriteLiteral("                                    <tr>\r\n                                        <td>\r\n                                            <span class=\"image\">\r\n                                                <img");
            BeginWriteAttribute("src", " src=\"", 1050, "\"", 1079, 2);
            WriteAttributeValue("", 1056, "/images/", 1056, 8, true);
            WriteAttributeValue("", 1064, 
#nullable restore
#line 32 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                                                                   item.BookImage

#line default
#line hidden
#nullable disable
            , 1064, 15, false);
            EndWriteAttribute();
            WriteLiteral(" height=\"120\" width=\"110\"");
            BeginWriteAttribute("alt", " alt=\"", 1105, "\"", 1111, 0);
            EndWriteAttribute();
            WriteLiteral(" />\r\n                                            </span>\r\n                                        </td>\r\n                                        <td>\r\n                                            ");
            Write(
#nullable restore
#line 36 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                                             item.BookTitle

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                                        </td>\r\n                                        <td>\r\n                                            ");
            Write(
#nullable restore
#line 39 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                                             item.Quantity

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                                        </td>\r\n                                    </tr>\r\n");
#nullable restore
#line 42 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                                
                            
                        }

#line default
#line hidden
#nullable disable

            WriteLiteral(@"                    </tbody>
                </table>
            </div>
        </div>

        <div class=""col-sm-4"">
            <div class=""row"">
                <label class=""col-sm-3"">Order ID</label>
                <div class=""col-sm-9"">
                    ");
            Write(
#nullable restore
#line 54 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.Id

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n                <label class=\"col-sm-3\">Name</label>\r\n                <div class=\"col-sm-9\">\r\n                    ");
            Write(
#nullable restore
#line 58 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.TenNguoiDatHang

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n                <label class=\"col-sm-3\">Email</label>\r\n                <div class=\"col-sm-9\">\r\n                    ");
            Write(
#nullable restore
#line 62 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.Email

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n                <label class=\"col-sm-3\">Phone</label>\r\n                <div class=\"col-sm-9\">\r\n                    ");
            Write(
#nullable restore
#line 66 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.SoDienThoai

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n                <label class=\"col-sm-3\">Address</label>\r\n                <div class=\"col-sm-9\">\r\n                    ");
            Write(
#nullable restore
#line 70 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.DiaChi

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n                <label class=\"col-sm-3\">Total Price</label>\r\n                <div class=\"col-sm-9\">\r\n                    ");
            Write(
#nullable restore
#line 74 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.TongTien.ToString("C")

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n                <label class=\"col-sm-3\">Status</label>\r\n                <div class=\"col-sm-9\">\r\n                    ");
            Write(
#nullable restore
#line 78 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                     Model.InfoOrder.TrangThaiTT

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n\r\n    <a class=\"button\"");
            BeginWriteAttribute("href", " href=\"", 3075, "\"", 3146, 1);
            WriteAttributeValue("", 3082, 
#nullable restore
#line 84 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                             Url.Action("EditOrder", new { id = Model.InfoOrder.DonHangId })

#line default
#line hidden
#nullable disable
            , 3082, 64, false);
            EndWriteAttribute();
            WriteLiteral(">Edit</a>\r\n    <a class=\"button\"");
            BeginWriteAttribute("href", " href=\"", 3179, "\"", 3213, 1);
            WriteAttributeValue("", 3186, 
#nullable restore
#line 85 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\DetailOrder.cshtml"
                             Url.Action("ManagerOrder")

#line default
#line hidden
#nullable disable
            , 3186, 27, false);
            EndWriteAttribute();
            WriteLiteral(">Back to List</a>\r\n</div>\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<WebStore.Models.OrderDetailViewModel> Html { get; private set; } = default!;
        #nullable disable
    }
}
#pragma warning restore 1591