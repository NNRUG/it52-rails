import React, { useMemo } from "react";
import "./table.css";
import dataa from './data.json'
import { useTable } from "react-table";

const Table = () => {

    //Создание колонок для таблицы
    const data = useMemo(() => dataa, []);
    const columns = useMemo(
        () => [
            {
                Header: "IT52 SPENT",
                accessor: "name",
            },
            {
                Header: "2014",
                accessor: "four",
            },
            {
                Header: "2015",
                accessor: "fife",
            },
            {
                Header: "2016",
                accessor: "six",
            },
            {
                Header: "2017",
                accessor: "seven",
            },
            {
                Header: "2018",
                accessor: "eght",
            },
            {
                Header: "2019 (estimate)",
                accessor: "nine",
            },
        ], []);

    const { getTableProps, getTableBodyProps, headerGroups, rows, prepareRow } =
        useTable({ columns, data });

    return (
        <div className="table__conteiner" >
            <div className="table__title">IT52 donations : Spent</div>
            <div className="table__wrapper">
                <table style={{ overflowX: 'auto' }} {...getTableProps()}>
                    <thead>
                        {headerGroups.map((headerGroup) => (
                            <tr {...headerGroup.getHeaderGroupProps()}>
                                {headerGroup.headers.map((column) => (
                                    <th {...column.getHeaderProps()}>
                                        {column.render("Header")}
                                    </th>
                                ))}
                            </tr>
                        ))}
                    </thead>

                    <tbody {...getTableBodyProps()}>
                        {rows.map((row, i) => {
                            prepareRow(row);
                            return (
                                <tr {...row.getRowProps()}>
                                    {row.cells.map((cell, index) => (

                                        <td {...cell.getCellProps()} className={rows[i].cells[index].value === 0 ? "zero" : "noZero"}
                                        >{isNaN(rows[i].cells[index].value) ?
                                            ''
                                            :
                                            '$'}{cell.render("Cell")}</td>
                                    ))}
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>
        </div>
        // <div className="table-container">
        //     <table>
        //         <tr>
        //             <th>IT52 SPENT</th>
        //             <th>2014</th>
        //             <th>2015</th>
        //             <th>2016</th>
        //             <th>2017</th>
        //             <th>2018</th>
        //             <th>2019 (estimate)</th>
        //         </tr>
        //         {data && data.map((val, key) => {
        //             return (
        //                 <tr key={key}>
        //                     <td>{val.name}</td>
        //                     <td>${val.four}</td>
        //                     <td>${val.fife}</td>
        //                     <td>${val.six}</td>
        //                     <td>${val.seven}</td>
        //                     <td>${val.eght}</td>
        //                     <td>${val.nine}</td>
        //                 </tr>
        //             )
        //         })}
        //     </table>
        // </div>
    );
}


export default Table