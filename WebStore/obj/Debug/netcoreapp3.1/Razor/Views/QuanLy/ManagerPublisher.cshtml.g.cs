#pragma checksum "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml" "{8829d00f-11b8-4213-878b-770e8597ac16}" "527db8573b146488da47bc6a61c6239dea697034b76b91e2e3df81875fc1e9be"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_QuanLy_ManagerPublisher), @"mvc.1.0.view", @"/Views/QuanLy/ManagerPublisher.cshtml")]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"Sha256", @"527db8573b146488da47bc6a61c6239dea697034b76b91e2e3df81875fc1e9be", @"/Views/QuanLy/ManagerPublisher.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"Sha256", @"0ca74d9d3d8f0fda11e57151523a5ee9557a88a1c5aba4211246523de85a92d1", @"/Views/_ViewImports.cshtml")]
    #nullable restore
    public class Views_QuanLy_ManagerPublisher : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<WebStore.Models.NhaXuatBanDTO>>
    #nullable disable
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
  
    ViewData["Title"] = "Quản lý nhà xuât bản";
    Layout = "~/Views/Shared/_ManagerLayout.cshtml";

#line default
#line hidden
#nullable disable

            WriteLiteral("\r\n<h1>Quản lý nhà xuất bản</h1>\r\n<table class=\"table\">\r\n    <thead>\r\n        <tr>\r\n            <th>\r\n                ");
            Write(
#nullable restore
#line 13 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                 Html.DisplayNameFor(model => model.Ten)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
            Write(
#nullable restore
#line 16 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                 Html.DisplayNameFor(model => model.DiaChi)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
            Write(
#nullable restore
#line 19 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                 Html.DisplayNameFor(model => model.SoDienThoai)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </th>\r\n            <th>\r\n                ");
            Write(
#nullable restore
#line 22 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                 Html.DisplayNameFor(model => model.Email)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n            </th>\r\n            <th></th>\r\n        </tr>\r\n    </thead>\r\n    <tbody>\r\n");
#nullable restore
#line 28 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
         foreach (var item in Model)
        {

#line default
#line hidden
#nullable disable

            WriteLiteral("            <tr>\r\n                <td>\r\n                    ");
            Write(
#nullable restore
#line 32 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.DisplayFor(modelItem => item.Ten)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
            Write(
#nullable restore
#line 35 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.DisplayFor(modelItem => item.DiaChi)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
            Write(
#nullable restore
#line 38 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.DisplayFor(modelItem => item.SoDienThoai)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
            Write(
#nullable restore
#line 41 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.DisplayFor(modelItem => item.Email)

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n                <td>\r\n                    ");
            Write(
#nullable restore
#line 44 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.ActionLink("Edit", "EditPublisher", new { id = item.IdNXB })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral(" |\r\n                    ");
            Write(
#nullable restore
#line 45 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.ActionLink("Details", "DetailPublisher", new { id = item.IdNXB })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral(" |\r\n                    ");
            Write(
#nullable restore
#line 46 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
                     Html.ActionLink("Delete", "DeletePublisher", new { id = item.IdNXB })

#line default
#line hidden
#nullable disable
            );
            WriteLiteral("\r\n                </td>\r\n            </tr>\r\n");
#nullable restore
#line 49 "C:\Users\chuon\Downloads\QuanLyBanSach\WebStore\WebStore\Views\QuanLy\ManagerPublisher.cshtml"
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<WebStore.Models.NhaXuatBanDTO>> Html { get; private set; } = default!;
        #nullable disable
    }
}
#pragma warning restore 1591
